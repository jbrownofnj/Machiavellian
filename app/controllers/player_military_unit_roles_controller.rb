class PlayerMilitaryUnitRolesController < ApplicationController
  before_action :set_player_military_unit_role, only: %i[ show edit update destroy ]
  before_action :set_player, only:[:index]
  before_action :set_game,onyl:[:index]
  before_action :logged_in?, only:[:index,:show,:new,:edit,:create,:update,:destroy]
  before_action :is_admin?, only:[:show,:new,:edit,:create,:update,:destroy]
  # GET /player_military_unit_roles or /player_military_unit_roles.json
  def index
    @player_military_unit_roles = @player.player_military_unit_roles
    @round=@game.matches.last.rounds.last
  end

  # GET /player_military_unit_roles/1 or /player_military_unit_roles/1.json
  def show
  end

  # GET /player_military_unit_roles/new
  def new
    @player_military_unit_role = PlayerMilitaryUnitRole.new
  end

  # GET /player_military_unit_roles/1/edit
  def edit
  end

  # POST /player_military_unit_roles or /player_military_unit_roles.json
  def create
    @player_military_unit_role = PlayerMilitaryUnitRole.new(player_military_unit_role_params)

    respond_to do |format|
      if @player_military_unit_role.save
        format.html { redirect_to player_military_unit_role_url(@player_military_unit_role), notice: "Player military unit role was successfully created." }
        format.json { render :show, status: :created, location: @player_military_unit_role }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @player_military_unit_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /player_military_unit_roles/1 or /player_military_unit_roles/1.json
  def update
    respond_to do |format|
      if @player_military_unit_role.update(player_military_unit_role_params)
        format.html { redirect_to player_military_unit_role_url(@player_military_unit_role), notice: "Player military unit role was successfully updated." }
        format.json { render :show, status: :ok, location: @player_military_unit_role }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @player_military_unit_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /player_military_unit_roles/1 or /player_military_unit_roles/1.json
  def destroy
    @player_military_unit_role.destroy

    respond_to do |format|
      format.html { redirect_to player_military_unit_roles_url, notice: "Player military unit role was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player_military_unit_role
      @player_military_unit_role = PlayerMilitaryUnitRole.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def player_military_unit_role_params
      params.require(:player_military_unit_role).permit(:player_id, :military_unit_id, :military_unit_role_type)
    end
end
