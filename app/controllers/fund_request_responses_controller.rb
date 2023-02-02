class FundRequestResponsesController < ApplicationController
  before_action :set_fund_request_response, only: %i[ show edit update destroy ]
  before_action :is_admin, only:[:index,:show,:new,:edit,:update,:destroy]
  before_action :logged_in?, only:[:index,:show,:new,:create,:update,:destroy,:edit]  # GET /fund_request_responses or /fund_request_responses.json
  def index
    @fund_request_responses = FundRequestResponse.all
  end

  # GET /fund_request_responses/1 or /fund_request_responses/1.json
  def show
  end

  # GET /fund_request_responses/new
  def new
    @fund_request_response = FundRequestResponse.new
  end

  # GET /fund_request_responses/1/edit
  def edit
  end

  # POST /fund_request_responses or /fund_request_responses.json
  def create
    @fund_request_response = FundRequestResponse.new(fund_request_response_params)
    respond_to do |format|
      if @fund_request_response.save
        format.html { redirect_to game_page_show_path, notice: "Your response has been sent my lord" }
        format.json { render :show, status: :created, location: @fund_request_response }
      else
        format.html { render :new, status: :unprocessable_entity}
        format.json { render json: @fund_request_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fund_request_responses/1 or /fund_request_responses/1.json
  def update
    respond_to do |format|
      if @fund_request_response.update(fund_request_response_params)
        format.html { redirect_to fund_request_response_url(@fund_request_response), notice: "Fund request response was successfully updated." }
        format.json { render :show, status: :ok, location: @fund_request_response }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @fund_request_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fund_request_responses/1 or /fund_request_responses/1.json
  def destroy
    @fund_request_response.destroy

    respond_to do |format|
      format.html { redirect_to fund_request_responses_url, notice: "Fund request response was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fund_request_response
      @fund_request_response = FundRequestResponse.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fund_request_response_params
      params.require(:fund_request_response).permit(:funding_request_id, :funding_request_player_role_id, :funding_request_response_type)
    end
end
