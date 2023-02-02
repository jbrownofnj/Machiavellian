class TradeRequestResourcesController < ApplicationController
  before_action :set_trade_request_resource, only: %i[ show edit update destroy ]
  before_action :logged_in?, only:[:index,:show,:new,:edit,:create,:update,:destroy]
  before_action :is_admin?, only:[:index,:show,:new,:edit,:create,:update,:destroy]
  # GET /trade_request_resources or /trade_request_resources.json
  def index

    @trade_request_resources = TradeRequestResource.all
    
  end

  # GET /trade_request_resources/1 or /trade_request_resources/1.json
  def show
  end

  # GET /trade_request_resources/new
  def new
    @trade_request_resource = TradeRequestResource.new
  end

  # GET /trade_request_resources/1/edit
  def edit
  end

  # POST /trade_request_resources or /trade_request_resources.json
  def create
    @trade_request_resource = TradeRequestResource.new(trade_request_resource_params)

    respond_to do |format|
      if @trade_request_resource.save
        format.html { redirect_to trade_request_resource_url(@trade_request_resource), notice: "Trade request resource was successfully created." }
        format.json { render :show, status: :created, location: @trade_request_resource }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @trade_request_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trade_request_resources/1 or /trade_request_resources/1.json
  def update
    respond_to do |format|
      if @trade_request_resource.update(trade_request_resource_params)
        format.html { redirect_to trade_request_resource_url(@trade_request_resource), notice: "Trade request resource was successfully updated." }
        format.json { render :show, status: :ok, location: @trade_request_resource }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @trade_request_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trade_request_resources/1 or /trade_request_resources/1.json
  def destroy
    @trade_request_resource.destroy

    respond_to do |format|
      format.html { redirect_to trade_request_resources_url, notice: "Trade request resource was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trade_request_resource
      @trade_request_resource = TradeRequestResource.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def trade_request_resource_params
      params.require(:trade_request_resource).permit(:trade_request_id, :trade_request_resource_type, :trade_request_resource_quantity,:number_of_trade_request_resources)
    end
end
