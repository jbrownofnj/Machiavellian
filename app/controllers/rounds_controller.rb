class RoundsController < ApplicationController
  before_action :set_round, only: %i[ show edit update destroy]
  before_action :set_game, only: [:end_round, :rescind_end_round]
  before_action :set_player, only: [:end_round, :rescind_end_round]
  before_action :logged_in?, only:[:index,:show,:new,:edit,:create,:update,:destroy,:rescind_end_round,:end_round]
  before_action :is_admin?, only:[:index,:show,:new,:edit,:create,:update,:destroy]
  # GET /rounds or /rounds.json
  def index
    @rounds = Round.all
  end

  # GET /rounds/1 or /rounds/1.json
  def show
  end

  # GET /rounds/new
  def new
    @round = Round.new
  end

  # GET /rounds/1/edit
  def edit
  end

  # POST /rounds or /rounds.json
  def create
    @round = Round.new(round_params)

    respond_to do |format|
      if @round.save
        format.html { redirect_to round_url(@round), notice: "Round was successfully created." }
        format.json { render :show, status: :created, location: @round }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rounds/1 or /rounds/1.json
  def update
    respond_to do |format|
      if @round.update(round_params)
        format.html { redirect_to round_url(@round), notice: "Round was successfully updated." }
        format.json { render :show, status: :ok, location: @round }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rounds/1 or /rounds/1.json
  def end_round
    @round=@game.current_round
    @end_round_action=PlayerAction.new(player:@player,round:@round,action_type:"end_round")
    if @end_round_action.save
      if @round.player_actions.where(action_type:"end_round").count >= @game.players.count
        raised_armies_become_military()
        units_away_degrade()
        move_military_units()
        finish_resource_generator_constructions()
        earn_from_resource_generators()
        
        if @round.match.is_over()
          @winner=@round.match.winner
          @points_won=@player.how_much_loyalty(@winner.house_name)
          @previous_victory_points=@winner.victory_points
          @new_victory_points=@previous_victory_points + @points_won
          @winner.update(victory_points:@new_victory_points)
          if @game.is_over
            @game.update(finished: true)
            @winners=@game.winners
            session[:game_id]=nil
            session[:player_id]=nil
            redirect_to results_page_url(@game) and return
          end
          @match=Match.create(game:@game)
          @game.clear_for_new_match
        end
        @new_round=Round.create(match:@game.matches.last) 
        respond_to do |format|
          format.html { redirect_to game_page_show_path, notice:"Ready to start a new round" }
          format.json { head :no_content }
        end
      else
        respond_to do |format|
          format.html { redirect_to game_page_show_path, notice:"Awaiting other players" }
          format.json { head :no_content }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to game_page_show_path,notice:"extra end round" }
        format.json { head :no_content }
      end
    end 
  end

  def rescind_end_round
    @end_round_action=@game.matches.last.rounds.last.player_actions.where(player:@player, action_type:"end_round")
    if @end_round_action.count>0
      @end_round_action.delete_all
      respond_to do |format|
        format.html { redirect_to game_page_show_path, notice:"Nevermind I dont want to end the round" }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to game_page_show_path}
        format.json { head :no_content }
      end
    end
   
  end
  def destroy
    @round.destroy

    respond_to do |format|
      format.html { redirect_to rounds_url, notice: "Round was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
      # Use callbacks to share common setup or constraints between actions.
  def earn_from_resource_generators()
    @game.players.each do |game_player|
      if game_player.is_not_routed
        if game_player.resource_generators&.each do |resource_generator|
          case resource_generator.resource_generator_type
          when "mine"
            if game_player.player_resources.find_by(resource_type:"gold")
              game_player.player_resources.find_by(resource_type:"gold").increment!(:resource_quantity)
            else
              PlayerResource.create(player:game_player,resource_type:"gold",resource_quantity:1)
            end
          when "castle"
            if game_player.player_resources.find_by(resource_type:"soldier")
              game_player.player_resources.find_by(resource_type:"soldier").increment!(:resource_quantity)
            else
              PlayerResource.create(player:game_player,resource_type:"soldier",resource_quantity:1)
            end
          when "embassy"
            if game_player.player_resources.find_by(resource_type:"spy")
              game_player.player_resources.find_by(resource_type:"spy").increment!(:resource_quantity)
            else
              PlayerResource.create(player:game_player,resource_type:"spy",resource_quantity:1)
            end
            end
          end 
        else
        end
      end
    end
  end
  
  def raised_armies_become_military()
    if @game.players&.each do |game_player|
      if game_player.player_actions&.each do |action|
        if action.action_type=="raise_army" && action.round == @round
            @military_unit=MilitaryUnit.new(military_unit_type:action.raise_armies.first.raise_army_type, military_unit_power:action.raise_armies.first.army_power,stance:"defense")
            if @military_unit.save
              @unit_owner=PlayerMilitaryUnitRole.new(military_unit:@military_unit,player:game_player,military_unit_role_type:"owner")
              @unit_holder=PlayerMilitaryUnitRole.new(military_unit:@military_unit,player:game_player,military_unit_role_type:"houser")
              @unit_owner.save 
              @unit_holder.save
            else
            end
          end
      end
    end
    end
  end
  end

  def move_military_units()
    if @game.players&.each do |game_player|
      if game_player.player_actions&.each do |action|
        if action.action_type=="move_army" && action.round == @round
          @move_command=action.move_armies.first
          @military_unit_to_move=@move_command.military_unit
          @houser_role=@military_unit_to_move.player_military_unit_roles.find_by(military_unit_role_type:"houser")
          @houser_role.update(player_id:@move_command.player_id)
          @military_unit_to_move.update(stance:@move_command.stance_command)
        end
      end
      end
    end
    end
  end

  def units_away_degrade
    if @game.players&.each do |game_player|
      if game_player.player_military_unit_roles&.each do |role|
     
        if role.military_unit_role_type == "houser" && role.military_unit.owner != game_player
          role.military_unit.update(military_unit_power:role.military_unit.military_unit_power-1 )
          if role.military_unit.military_unit_power <= 0
            role.military_unit.destroy
          end
        end
      end
      end
    end
    end
  end

  def finish_resource_generator_constructions()
    @game.players.each do |player|
      player.constructions&.each do |construction|
        if construction.is_funded && construction.funded==false          
          construction.update(funded:true)
          resource_generator_type=construction.resource_generator_constructions.first.resource_generator_type
          construction_owner=construction.player
          ResourceGenerator.create(player:construction_owner,resource_generator_type:resource_generator_type)
        end
      end
    end
  end

    def set_round
      @round = Round.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def round_params
      params.require(:round).permit(:match_id)
    end
end