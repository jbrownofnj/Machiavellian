class PlayerLoyaltiesController < ApplicationController
  before_action :set_player_loyalty, only: %i[ show edit update destroy ]
  before_action :logged_in?, only:[:index,:show,:new,:edit,:create,:update,:destroy]
  before_action :is_admin?, only:[:index,:show,:new,:edit,:create,:update,:destroy]
  # GET /player_loyalties or /player_loyalties.json
  def index
    @player_loyalties = PlayerLoyalty.all
  end

  # GET /player_loyalties/1 or /player_loyalties/1.json
  def show
  end

  # GET /player_loyalties/new
  def new
    @player_loyalty = PlayerLoyalty.new
  end

  # GET /player_loyalties/1/edit
  def edit
  end

  # POST /player_loyalties or /player_loyalties.json
  def create
    @player_loyalty = PlayerLoyalty.new(player_loyalty_params)

    respond_to do |format|
      if @player_loyalty.save
        format.html { redirect_to player_loyalty_url(@player_loyalty), notice: "Player loyalty was successfully created." }
        format.json { render :show, status: :created, location: @player_loyalty }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @player_loyalty.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /player_loyalties/1 or /player_loyalties/1.json
  def update
    respond_to do |format|
      if @player_loyalty.update(player_loyalty_params)
        format.html { redirect_to player_loyalty_url(@player_loyalty), notice: "Player loyalty was successfully updated." }
        format.json { render :show, status: :ok, location: @player_loyalty }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @player_loyalty.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /player_loyalties/1 or /player_loyalties/1.json
  def destroy
    @player_loyalty.destroy

    respond_to do |format|
      format.html { redirect_to player_loyalties_url, notice: "Player loyalty was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player_loyalty
      @player_loyalty = PlayerLoyalty.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def player_loyalty_params
      params.require(:player_loyalty).permit(:player_loyalty_quantity)
    end
end
