class FundingRequestResourcesController < ApplicationController
  before_action :set_funding_request_resource, only: %i[ show edit update destroy ]
  before_action :is_admin, only:[:index,:show,:new,:edit,:create,:update,:destroy]
  before_action :logged_in?, only:[:index,:show,:new,:edit,:create,:update,:destroy]
  # GET /funding_request_resources or /funding_request_resources.json
  def index
    @funding_request_resources = FundingRequestResource.all
  end

  # GET /funding_request_resources/1 or /funding_request_resources/1.json
  def show
  end

  # GET /funding_request_resources/new
  def new
    @funding_request_resource = FundingRequestResource.new
  end

  # GET /funding_request_resources/1/edit
  def edit
  end

  # POST /funding_request_resources or /funding_request_resources.json
  def create
    @funding_request_resource = FundingRequestResource.new(funding_request_resource_params)

    respond_to do |format|
      if @funding_request_resource.save
        format.html { redirect_to funding_request_resource_url(@funding_request_resource), notice: "Funding request resource was successfully created." }
        format.json { render :show, status: :created, location: @funding_request_resource }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @funding_request_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /funding_request_resources/1 or /funding_request_resources/1.json
  def update
    respond_to do |format|
      if @funding_request_resource.update(funding_request_resource_params)
        format.html { redirect_to funding_request_resource_url(@funding_request_resource), notice: "Funding request resource was successfully updated." }
        format.json { render :show, status: :ok, location: @funding_request_resource }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @funding_request_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /funding_request_resources/1 or /funding_request_resources/1.json
  def destroy
    @funding_request_resource.destroy

    respond_to do |format|
      format.html { redirect_to funding_request_resources_url, notice: "Funding request resource was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_funding_request_resource
      @funding_request_resource = FundingRequestResource.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def funding_request_resource_params
      params.require(:funding_request_resource).permit(:funding_request_id, :funding_resource_type, :funding_resource_amount)
    end
end
