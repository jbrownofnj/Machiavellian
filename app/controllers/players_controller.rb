class PlayersController < ApplicationController
  before_action :set_player, only: %i[ show edit update destroy ]
  before_action :set_user, only:[:create]
  before_action :logged_in?, only:[:index,:show,:new,:edit,:create,:update,:destroy]
  before_action :is_admin?, only:[:index,:show,:new,:edit,:update,:destroy]
  # GET /players or /players.json
  def index
    @players = Player.all
  end

  # GET /players/1 or /players/1.json
  def show
  end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players or /players.json
  def create
    @game=Game.find_by(game_name:player_params[:game_name])
    @player = Player.new(game:@game,house_name: "#{player_params[:house_name].capitalize} house",user:User.find(session[:user_id]))
    respond_to do |format|
      if @player.save && @game&.authenticate(player_params[:password])
        @player_loyalty=PlayerLoyalty.new(player_loyalty_quantity:100)
        @player_loyalty_role_holder=PlayerLoyaltyRole.new(player_loyalty_role_type:"holder",player:@player,player_loyalty:@player_loyalty)
        @player_loyalty_role_owner=PlayerLoyaltyRole.new(player_loyalty_role_type:"owner",player:@player,player_loyalty:@player_loyalty)
        @first_mine=ResourceGenerator.new(resource_generator_type:"mine",player:@player)
        @first_gold=PlayerResource.new(resource_type:"gold", resource_quantity:1, player:@player)
        if  @player_loyalty.save && @player_loyalty_role_holder.save && @player_loyalty_role_owner.save && @first_mine.save && @first_gold.save
          @spot="after all players loyalties save"
          session[:game_id]=@game.id
          session[:player_id]=@player.id
          format.html { redirect_to game_page_show_path(game:@game), notice: "Player was successfully created." }
          format.json { render :show, status: :created, location: @player }
        else
          format.html { redirect_to game_pages_path,notice:"Something strange happened with loyalty my lord." }
        end
      else
        format.html { redirect_to game_pages_path,notice:"My lord it appears that house name is taken or your some info there is wrong." }
      end
    end
  end

  # PATCH/PUT /players/1 or /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to player_url(@player), notice: "Player was successfully updated." }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1 or /players/1.json
  def destroy
    @player.destroy

    respond_to do |format|
      format.html { redirect_to players_url, notice: "Player was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def player_params
      params.require(:player).permit(:game_name, :house_name,:password)
    end
end
