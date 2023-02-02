class FundingRequestPlayerRolesController < ApplicationController
  before_action :set_funding_request_player_role, only: %i[ show edit update destroy ]
  before_action :is_admin, only:[:index,:show,:new,:edit,:create,:update,:destroy]
  before_action :logged_in?, only:[:index,:show,:new,:edit,:create,:update,:destroy]

  # GET /funding_request_player_roles or /funding_request_player_roles.json
  def index
    @funding_request_player_roles = FundingRequestPlayerRole.all
  end

  # GET /funding_request_player_roles/1 or /funding_request_player_roles/1.json
  def show
  end

  # GET /funding_request_player_roles/new
  def new
    @funding_request_player_role = FundingRequestPlayerRole.new
  end

  # GET /funding_request_player_roles/1/edit
  def edit
  end

  # POST /funding_request_player_roles or /funding_request_player_roles.json
  def create
    @funding_request_player_role = FundingRequestPlayerRole.new(funding_request_player_role_params)

    respond_to do |format|
      if @funding_request_player_role.save
        format.html { redirect_to funding_request_player_role_url(@funding_request_player_role), notice: "Funding request player role was successfully created." }
        format.json { render :show, status: :created, location: @funding_request_player_role }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @funding_request_player_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /funding_request_player_roles/1 or /funding_request_player_roles/1.json
  def update
    respond_to do |format|
      if @funding_request_player_role.update(funding_request_player_role_params)
        format.html { redirect_to funding_request_player_role_url(@funding_request_player_role), notice: "Funding request player role was successfully updated." }
        format.json { render :show, status: :ok, location: @funding_request_player_role }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @funding_request_player_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /funding_request_player_roles/1 or /funding_request_player_roles/1.json
  def destroy
    @funding_request_player_role.destroy

    respond_to do |format|
      format.html { redirect_to funding_request_player_roles_url, notice: "Funding request player role was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_funding_request_player_role
      @funding_request_player_role = FundingRequestPlayerRole.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def funding_request_player_role_params
      params.require(:funding_request_player_role).permit(:player_id, :funding_request_id, :player_role)
    end
end
