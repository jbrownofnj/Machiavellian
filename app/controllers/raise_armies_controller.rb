class RaiseArmiesController < ApplicationController
  before_action :set_raise_army, only: %i[ show edit update destroy ]
  before_action :set_user
  before_action :set_player
  before_action :set_game
  before_action :logged_in?, only:[:index,:show,:new,:edit,:create,:update,:destroy]
  before_action :is_admin?, only:[:index,:show,:edit,:update,:destroy]
  # GET /raise_armies or /raise_armies.json
  def index
    @raise_armies = RaiseArmy.all
  end

  # GET /raise_armies/1 or /raise_armies/1.json
  def show
  end

  # GET /raise_armies/new
  def new
    @raise_army = RaiseArmy.new
    @player_action= PlayerAction.new
  end

  # GET /raise_armies/1/edit
  def edit
  end

  # POST /raise_armies or /raise_armies.json
  def create
    @current_round=@game.matches.last.rounds.last
    @player_action=PlayerAction.new(player:@player,round:@current_round,action_type:"raise_army")
    @soldier_resource=@player.player_resources.find_by(resource_type:"soldier")  
    @soldier_count=@soldier_resource&.resource_quantity
    @soldier_count||=0
    @soldier_cost=params[:raise_army][:army_power].to_i
    @spy_resource=@player.player_resources.find_by(resource_type:"spy")
    @spy_count=@spy_resource&.resource_quantity
    @spy_count||=0
    @spy_cost=@soldier_cost/2+@soldier_cost%2
    if params[:raise_army][:raise_army_type]=="mercenary" 
      if @soldier_count >= @soldier_cost && @spy_count >= @soldier_cost/2 && @player_action.save
        @raise_army = RaiseArmy.new(army_power:params[:raise_army][:army_power],player_action:@player_action,raise_army_type:"mercenary")
        if @raise_army.save
          if @soldier_count==@soldier_cost
            @soldier_resource.destroy        
          else
            @soldier_resource.update(resource_quantity:@spy_count-@soldier_cost)
          end
          if @spy_count==@spy_cost
            @spy_resource.destroy        
          else
            @spy_resource.update(resource_quantity:@spy_count - @spy_cost)
          end
          respond_to do |format|
            format.html { redirect_to game_page_show_path(game:@game), notice: "Sucessfully Raised a Unit." }
          end
        else
          respond_to do |format|
            @player_action.destroy
            flash[:notice]="Woah. You dont have what you need for those mercenaries there!"
            format.html { render :new, status: :unprocessable_entity }
          end
        end
      end
     
    else params[:raise_army][:raise_army_type]=="army"
      if @soldier_count >= @soldier_cost && @player_action.save
        @raise_army = RaiseArmy.new(army_power:params[:raise_army][:army_power],player_action:@player_action,raise_army_type:"army")
        if @raise_army.save
          if @soldier_count==@soldier_cost
            @soldier_resource.destroy
          else
            @soldier_resource.update(resource_quantity:@soldier_count-@soldier_cost)
          end
          redirect_to game_page_show_path
        else
          respond_to do |format|
            @player_action.destroy
            flash[:notice]="Woah. You dont have what you need for that army there!"
            format.html { render :new, status: :unprocessable_entity }
          end
        end
      end
    end
  end

  # PATCH/PUT /raise_armies/1 or /raise_armies/1.json
  def update
    respond_to do |format|
      if @raise_army.update(raise_army_params)
        format.html { redirect_to raise_army_url(@raise_army), notice: "Raise army was successfully updated." }
        format.json { render :show, status: :ok, location: @raise_army }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @raise_army.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /raise_armies/1 or /raise_armies/1.json
  def destroy
    @raise_army.destroy

    respond_to do |format|
      format.html { redirect_to raise_armies_url, notice: "Raise army was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_raise_army
      @raise_army = RaiseArmy.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def raise_army_params
      params.require(:raise_army).permit(:army_power,:raise_army_type)
    end
end
