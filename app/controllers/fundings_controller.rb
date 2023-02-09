class FundingsController < ApplicationController
  before_action :set_funding, only: %i[ show edit update destroy ]
  before_action :is_admin?, only:[:index,:show,:new,:edit,:update,:destroy]
  before_action :logged_in?, only:[:index,:show,:edit,:new,:create,:update,:destroy]
  # GET /fundings or /fundings.json
  def index
    @fundings = Funding.all
  end

  # GET /fundings/1 or /fundings/1.json
  def show
  end

  # GET /fundings/new
  def new
    @funding = Funding.new
  end

  # GET /fundings/1/edit
  def edit
  end

  # POST /fundings or /fundings.json
  def create
    @funding_request=FundingRequest.find(funding_params[:funding_request])
    @owner=@funding_request.owner
    @funder=@funding_request.funder
    @response=FundRequestResponse.new(funding_request:@funding_request,funding_request_player_role:@funding_request.funding_request_player_roles.find_by(player_role:"funder"), funding_request_response_type:"accept")
    respond_to do |format|
      if @response.save
        @funding_request.funding_request_resources&.each do |resource|
          #Determines if a funding of a given type are present already to add to that instead of making a new one.
          if @funding_request.construction.fundings&.find_by(funding_resource_type:resource.funding_resource_type.downcase)
            #Determines of the funder has enough of the given reasource.
            if @funder.has_enough_resource(resource.funding_resource_type,resource.funding_resource_amount)
              existing_fund=@funding_request.construction.fundings.find_by(funding_resource_type:resource.funding_resource_type)
              existing_fund.update(funding_resource_amount:existing_fund.funding_resource_amount+resource.funding_resource_amount)
              @funder.lose_resource(resource.funding_resource_type.downcase,resource.funding_resource_amount)
            else
                @response.destroy
                format.html { redirect_to game_page_show_path and return}
            end
          else   
            newfunding=Funding.create(construction:@funding_request.construction, funding_resource_type:resource.funding_resource_type.downcase, funding_resource_amount:resource.funding_resource_amount)
          end
        end
        format.html { redirect_to game_page_show_path, notice: "Good choice my lord" }
      else
        format.html { redirect_to game_page_show_path, notice: "Something went wrong my lord!" }
      end
    end

  end

  # PATCH/PUT /fundings/1 or /fundings/1.json
  def update
    respond_to do |format|
      if @funding.update(funding_params)
        format.html { redirect_to funding_url(@funding), notice: "Funding was successfully updated." }
        format.json { render :show, status: :ok, location: @funding }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @funding.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fundings/1 or /fundings/1.json
  def destroy
    @funding.destroy

    respond_to do |format|
      format.html { redirect_to fundings_url, notice: "Funding was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_funding
      @funding = Funding.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def funding_params
      params.require(:funding).permit(:funding_request)
    end
end
