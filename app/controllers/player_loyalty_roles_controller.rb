class PlayerLoyaltyRolesController < ApplicationController
  before_action :set_player_loyalty_role, only: %i[ show edit update destroy ]
  before_action :logged_in?, only:[:index,:show,:new,:edit,:create,:update,:destroy]
  before_action :is_admin?, only:[:index,:show,:new,:edit,:create,:update,:destroy]
  # GET /player_loyalty_roles or /player_loyalty_roles.json
  def index
    @player_loyalty_roles = PlayerLoyaltyRole.all
  end

  # GET /player_loyalty_roles/1 or /player_loyalty_roles/1.json
  def show
  end

  # GET /player_loyalty_roles/new
  def new
    @player_loyalty_role = PlayerLoyaltyRole.new
  end

  # GET /player_loyalty_roles/1/edit
  def edit
  end

  # POST /player_loyalty_roles or /player_loyalty_roles.json
  def create
    @player_loyalty_role = PlayerLoyaltyRole.new(player_loyalty_role_params)

    respond_to do |format|
      if @player_loyalty_role.save
        format.html { redirect_to player_loyalty_role_url(@player_loyalty_role), notice: "Player loyalty role was successfully created." }
        format.json { render :show, status: :created, location: @player_loyalty_role }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @player_loyalty_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /player_loyalty_roles/1 or /player_loyalty_roles/1.json
  def update
    respond_to do |format|
      if @player_loyalty_role.update(player_loyalty_role_params)
        format.html { redirect_to player_loyalty_role_url(@player_loyalty_role), notice: "Player loyalty role was successfully updated." }
        format.json { render :show, status: :ok, location: @player_loyalty_role }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @player_loyalty_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /player_loyalty_roles/1 or /player_loyalty_roles/1.json
  def destroy
    @player_loyalty_role.destroy

    respond_to do |format|
      format.html { redirect_to player_loyalty_roles_url, notice: "Player loyalty role was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player_loyalty_role
      @player_loyalty_role = PlayerLoyaltyRole.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def player_loyalty_role_params
      params.require(:player_loyalty_role).permit(:player_id, :player_loyalty_id, :player_loyalty_role_type)
    end
end
