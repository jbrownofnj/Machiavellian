class MoveArmiesController < ApplicationController
  before_action :set_move_army, only: %i[ show edit update destroy ]
  before_action :set_player,only:[:new,:create]
  before_action :set_game,only:[:new,:create]
  before_action :logged_in?, only:[:index,:show,:new,:edit,:create,:update,:destroy]
  before_action :is_admin?, only:[:index,:show,:edit,:update,:destroy]
  
  # GET /move_armies or /move_armies.json
  def index
    @move_armies = MoveArmy.all
  end

  # GET /move_armies/1 or /move_armies/1.json
  def show
  end

  # GET /move_armies/new
  def new
    @move_army = MoveArmy.new()
  end

  # GET /move_armies/1/edit
  def edit
  end

  # POST /move_armies or /move_armies.json
  def create
    @player_action=PlayerAction.new(player:@player,action_type:"move_army",round:@game.matches.last.rounds.last)
    if @player_action.save
      @move_army = MoveArmy.new(player_id:move_army_params[:player_id].to_i,player_action:@player_action, military_unit_id:move_army_params[:military_unit_id].to_i,stance_command:move_army_params[:stance_command])
      if @move_army.save
         redirect_to game_page_show_path
      else
        @player_action.destroy
        respond_to do |format|
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
      end
    end
   
  end

  # PATCH/PUT /move_armies/1 or /move_armies/1.json
  def update
    respond_to do |format|
      if @move_army.update(move_army_params)
        format.html { redirect_to move_army_url(@move_army), notice: "Move army was successfully updated." }
        format.json { render :show, status: :ok, location: @move_army }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @move_army.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /move_armies/1 or /move_armies/1.json
  def destroy
    @move_army.destroy

    respond_to do |format|
      format.html { redirect_to move_armies_url, notice: "Move army was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_move_army
      @move_army = MoveArmy.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def move_army_params
      params.require(:move_army).permit(:player_id, :military_unit_id,:stance_command)
    end
end
