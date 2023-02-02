class PlayerResourcesController < ApplicationController
  before_action :set_player_resource, only: %i[ show edit update destroy ]
  before_action :set_player,only: [:index]
  before_action :logged_in?, only:[:index,:show,:new,:edit,:create,:update,:destroy]
  before_action :is_admin?, only:[:show,:new,:edit,:create,:update,:destroy]
  # GET /player_resources or /player_resources.json
  def index
    @player_resources = @player.player_resources
    @player_loyalty_roles = @player.player_loyalty_roles.where(player_loyalty_role_type:"holder")
    @resource_generators=@player.resource_generators
    @no_resources=@player_resources.count>0? false:true
  end

  # GET /player_resources/1 or /player_resources/1.json
  def show
  end

  # GET /player_resources/new
  def new
    @player_resource = PlayerResource.new
  end

  # GET /player_resources/1/edit
  def edit
  end

  # POST /player_resources or /player_resources.json
  def create
    @player_resource = PlayerResource.new(player_resource_params)

    respond_to do |format|
      if @player_resource.save
        format.html { redirect_to player_resource_url(@player_resource), notice: "Player resource was successfully created." }
        format.json { render :show, status: :created, location: @player_resource }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @player_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /player_resources/1 or /player_resources/1.json
  def update
    respond_to do |format|
      if @player_resource.update(player_resource_params)
        format.html { redirect_to player_resource_url(@player_resource), notice: "Player resource was successfully updated." }
        format.json { render :show, status: :ok, location: @player_resource }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @player_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /player_resources/1 or /player_resources/1.json
  def destroy
    @player_resource.destroy

    respond_to do |format|
      format.html { redirect_to player_resources_url, notice: "Player resource was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player_resource
      @player_resource = PlayerResource.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def player_resource_params
      params.require(:player_resource).permit(:player_id, :resource_quantity, :resource_type)
    end
end
