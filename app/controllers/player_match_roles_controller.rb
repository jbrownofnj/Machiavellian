class PlayerMatchRolesController < ApplicationController
  before_action :set_player_match_role, only: %i[ show edit update destroy ]
  before_action :logged_in?, only:[:index,:show,:new,:edit,:create,:update,:destroy]
  before_action :is_admin?, only:[:index,:show,:new,:edit,:create,:update,:destroy]
  # GET /player_match_roles or /player_match_roles.json
  def index
    @player_match_roles = PlayerMatchRole.all
  end

  # GET /player_match_roles/1 or /player_match_roles/1.json
  def show
  end

  # GET /player_match_roles/new
  def new
    @player_match_role = PlayerMatchRole.new
  end

  # GET /player_match_roles/1/edit
  def edit
  end

  # POST /player_match_roles or /player_match_roles.json
  def create
    @player_match_role = PlayerMatchRole.new(player_match_role_params)

    respond_to do |format|
      if @player_match_role.save
        format.html { redirect_to player_match_role_url(@player_match_role), notice: "Player match role was successfully created." }
        format.json { render :show, status: :created, location: @player_match_role }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @player_match_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /player_match_roles/1 or /player_match_roles/1.json
  def update
    respond_to do |format|
      if @player_match_role.update(player_match_role_params)
        format.html { redirect_to player_match_role_url(@player_match_role), notice: "Player match role was successfully updated." }
        format.json { render :show, status: :ok, location: @player_match_role }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @player_match_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /player_match_roles/1 or /player_match_roles/1.json
  def destroy
    @player_match_role.destroy

    respond_to do |format|
      format.html { redirect_to player_match_roles_url, notice: "Player match role was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player_match_role
      @player_match_role = PlayerMatchRole.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def player_match_role_params
      params.require(:player_match_role).permit(:match_id, :player_id, :player_match_role_type)
    end
end
