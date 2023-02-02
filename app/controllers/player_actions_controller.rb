class PlayerActionsController < ApplicationController
  before_action :set_player_action, only: %i[ show edit update destroy ]
  before_action :set_game,only:[:index,:new,:create,:create_raise_army_action,:move_army]
  before_action :set_user,only:[:index,:new,:create,:create_raise_army_action,:move_army]
  before_action :set_player,only:[:index,:new,:create,:create_raise_army_action,:move_army]
  before_action :logged_in?, only:[:index,:show,:new,:edit,:create,:update,:destroy]
  before_action :is_admin?, only:[:show,:new,:edit,:update,:destroy]
  # GET /player_actions or /player_actions.json
  def index
    @player_action=PlayerAction.new()
    @round=@game.matches.last.rounds.last
  end

  # GET /player_actions/1 or /player_actions/1.json
  def show
  end

  # GET /player_actions/new
  def new
    @player_action = PlayerAction.new
    
    render :new, status: 422
  end

  # GET /player_actions/1/edit
  def edit
  end

  # POST /player_actions or /player_actions.json
  def create
    @player_action = PlayerAction.new(player:@player,round:@game.matches.last.rounds.last,action_type:"gathered_information")
    if player_action_params[:type_of_information]
      @gathered_information=GatherInformation.new(player_action:@player_action,information_type:player_action_params[:type_of_information])
      respond_to do |format|
        if @player_action.save && @gathered_information.save
          format.html { redirect_to gather_information_url(@gather_information), notice: "Player action was successfully created." }
        else
          format.html { redirect_to game_page_show_path,notice:"Failed to gather info" }
        
        end
      end
    end
  end

  
  def create_raise_army_action
    
    @player_action=PlayerAction.new(action_type:"raise_army,", player:@player, round:@game.matches.last.rounds.last)
    if @player_action.save
      redirect_to url_from("/raise_army"), action: "create"
    end

  end
  def move_army
  
      redirect_to url_from("/move_army"), action: "new"
   
  end

  # PATCH/PUT /player_actions/1 or /player_actions/1.json
  def update
    respond_to do |format|
      if @player_action.update(player_action_params)
        format.html { redirect_to player_action_url(@player_action), notice: "Player action was successfully updated." }
        format.json { render :show, status: :ok, location: @player_action }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @player_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /player_actions/1 or /player_actions/1.json
  def destroy
    @player_action.destroy

    respond_to do |format|
      format.html { redirect_to player_actions_url, notice: "Player action was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player_action
      @player_action = PlayerAction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.

    def player_action_params
      params.require(:player_action).permit(:type_of_information)
    end
end
