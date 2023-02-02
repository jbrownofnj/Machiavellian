class GamesController < ApplicationController
  before_action :set_game, only: %i[ show edit update destroy ]
  before_action :set_user,only: [:create,:destroy]
  before_action :is_admin?, only:[:index,:show,:edit,:update]
  before_action :logged_in?, only:[:index,:show,:edit,:new,:create,:update,:destroy]
  # GET /games or /games.json
  def index
    @games = Game.all

  end

  # GET /games/1 or /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
   
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games or /games.json
  def create
    @game = Game.new(game_name:game_params[:game_name].downcase,password:game_params[:password])
    respond_to do |format|
      if @game.save
        @first_player=Player.new(game:@game,user:User.find(session[:user_id]),house_name:game_params[:players_attributes]["0"][:house_name])
        @match=@game.matches.build
        @round=@match.rounds.build
        
        if @first_player.save && @match.save && @round.save
          @player_loyalty=PlayerLoyalty.new(player_loyalty_quantity:60)
          @player_loyalty_role_holder=PlayerLoyaltyRole.new(player_loyalty_role_type:"holder",player:@game.players.first,player_loyalty:@player_loyalty)
          @player_loyalty_role_owner=PlayerLoyaltyRole.new(player_loyalty_role_type:"owner",player:@game.players.first,player_loyalty:@player_loyalty)
          @first_mine=ResourceGenerator.new(resource_generator_type:"mine",player:@game.players.first)
          @first_gold=PlayerResource.new(player:@game.players.first,resource_quantity:1,resource_type:"gold")
          
          if @player_loyalty.save && @player_loyalty_role_holder.save && @player_loyalty_role_owner.save && @first_mine.save && @first_gold.save
          session[:game_id]=@game
          session[:player_id]=@player
          format.html { redirect_to game_page_show_path(game:@game), notice: "Game was successfully created." }
          format.json { render :show, status: :created, location: @game }
          else
            format.html { redirect_to game_pages_path,notice:"Loyalty issues arose" }
            format.json { render json: @game.errors, status: :unprocessable_entity }
          end

        else
            format.html { redirect_to game_pages_path,notice:"Problem with Player matches and rounds" }
            format.json { render json: @game.errors, status: :unprocessable_entity }
        end

      else
        format.html { redirect_to game_pages_path,notice:"Looks like that game name is taken or something is wrong" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
      
    end
  end

  # PATCH/PUT /games/1 or /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to game_url(@game), notice: "Game was successfully updated." }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1 or /games/1.json
  def destroy
      session[:player_id]=nil
      session[:game_id]=nil
      respond_to do |format|
        if @game.players.first.user==@user
          @game.destroy
          format.html { redirect_to game_pages_path, notice: "Game was successfully destroyed." }
        else
          format.html{redirect_to game_pages_path, alert:"That is not your game to destroy!"}
        end
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_params
      params.require(:game).permit(:game_name, :password,players_attributes:[:house_name,:user_id])
    end
end
