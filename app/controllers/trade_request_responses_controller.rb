class TradeRequestResponsesController < ApplicationController
  before_action :set_trade_request_response, only: %i[ show edit update destroy ]
  before_action :logged_in?, only:[:index,:show,:new,:edit,:create,:update,:destroy]
  before_action :is_admin?, only:[:index,:show,:new,:edit,:update,:destroy]
  before_action :set_player, only:[:create]
  # GET /trade_request_responses or /trade_request_responses.json
  def index
    @trade_request_responses = TradeRequestResponse.all
  end

  # GET /trade_request_responses/1 or /trade_request_responses/1.json
  def show
  end

  # GET /trade_request_responses/new
  def new
    @trade_request_response = TradeRequestResponse.new
  end

  # GET /trade_request_responses/1/edit
  def edit
  end

  # POST /trade_request_responses or /trade_request_responses.json
  def create

    @trade_request_response = TradeRequestResponse.new(trade_player_role_id:trade_request_response_params[:trade_player_role_id],trade_request_id:trade_request_response_params[:trade_request_id],trade_response_type:trade_request_response_params[:trade_response_type])
    @trade_request=TradeRequest.find(trade_request_response_params[:trade_request_id])
    @sender=@trade_request.sender
    can_afford_trade=@sender.can_afford_trade?(@trade_request)

    respond_to do |format|
      if @trade_request_response.save
        #choice between accept or reject
        if @trade_request_response.trade_response_type == "accept"
          if can_afford_trade
            @trade_request.payout
          else
            @trade_request_response&.destroy
            format.html { redirect_to trade_player_roles_path, notice:"Player lacks to resources they promised!" }
          end
        elsif @trade_request_response.trade_response_type == "reject"
          #ensures responses are accept or reject
        else
          @trade_request_response&.destroy
          format.html { redirect_to game_page_show_path, notice: "That is not an acceptable responce." }
        end
        format.html { redirect_to trade_player_roles_path, notice: "A fine choice my lord!" }
      else
        format.html { redirect_to trade_player_roles_path, notice:"Your attempt to respond failed my lord." }
      end
    end
  end

  # PATCH/PUT /trade_request_responses/1 or /trade_request_responses/1.json
  def update
    respond_to do |format|
      if @trade_request_response.update(trade_request_response_params)
        format.html { redirect_to trade_request_response_url(@trade_request_response), notice: "Trade request response was successfully updated." }
        format.json { render :show, status: :ok, location: @trade_request_response }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @trade_request_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trade_request_responses/1 or /trade_request_responses/1.json
  def destroy
    @trade_request_response.destroy

    respond_to do |format|
      format.html { redirect_to trade_request_responses_url, notice: "Trade request response was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trade_request_response
      @trade_request_response = TradeRequestResponse.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def trade_request_response_params
      params.require(:trade_request_response).permit(:trade_player_role_id, :trade_request_id, :trade_response_type)
    end
end
