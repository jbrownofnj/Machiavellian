class FundingRequestsController < ApplicationController
  before_action :set_funding_request, only: %i[ show edit update destroy ]
  before_action :set_player,only: [:new,:create,:destroy]
  before_action :set_game,only: [:new,:create]
  before_action :is_admin?, only:[:index,:show,:edit,:update]
  before_action :logged_in?, only:[:index,:show,:new,:edit,:create,:update,:destroy]

  # GET /funding_requests or /funding_requests.json
  def index
    @funding_requests = FundingRequest.all
  end

  # GET /funding_requests/1 or /funding_requests/1.json
  def show
  end

  # GET /funding_requests/new
  def new
    @funding_request = FundingRequest.new
  end

  # GET /funding_requests/1/edit
  def edit
  end

  # POST /funding_requests or /funding_requests.json
  def create
    case funding_request_params[:construction_resource_ptp_type]
      when "Embassy"
        @construction_type="resource_generator_construction"
      when "Castle"
        @construction_type="resource_generator_construction"
      when "Mine"
        @construction_type="resource_generator_construction"
      when "War"
        @construction_type="path_to_power_construction"
      when "Wealth"
        @construction_type="path_to_power_construction"
      when "Subterfuge"
        @construction_type="path_to_power_construction"
    end

    if @construction_type=="resource_generator_construction" && funding_request_params[:resource_type].downcase=="gold"
      @player_rg_constructions=@player.constructions.where(construction_type:"resource_generator_construction",funded:false)
      @player_rg_constructions.each do |player_construction|
        if player_construction.resource_generator_constructions.first.resource_generator_type == funding_request_params[:construction_resource_ptp_type].downcase
          @funding_request = FundingRequest.new(round:@game.matches.last.rounds.last,construction:player_construction )
            if @funding_request.unique_funder_for_turn(@game.players.find_by(house_name:funding_request_params[:player])) && @funding_request.save
              @player_giving_funds=FundingRequestPlayerRole.new(funding_request:@funding_request,player:@game.players.find_by(house_name:funding_request_params[:player]),player_role:"funder")
              @player_accepting_funds=FundingRequestPlayerRole.new(funding_request:@funding_request,player:@player,player_role:"owner")
              if @player_giving_funds.save && @player_accepting_funds.save
                
                @funding_request_resource=FundingRequestResource.new(funding_request:@funding_request,funding_resource_type:funding_request_params[:resource_type].downcase,funding_resource_amount:funding_request_params[:amount])
              
                if @funding_request_resource.save
                  redirect_to game_page_show_path, notice: "We await a responce my lord."and return
                else
                  @player_giving_funds.destroy
                  @player_accepting_funds.destroy
                  @funding_request.destroy
                  render :new, status: :unprocessable_entity, alert: "Sorry something went wrong my lord!" and return
                end
               
              else
                @funding_request.destroy
                render :new, status: :unprocessable_entity, alert: "Sorry something went wrong my lord!" and return
              end
            else
              @funding_request.errors.add(funding_request_params[:resource_type],"Reminder: You already asked them for funding this round for this resource generator.")
              render :new, status: :unprocessable_entity and return
            end
          
        end
      end
    elsif @construction_type=="path_to_power_construction"
      @player_rg_constructions=@player.constructions.where(construction_type:"path_to_power_construction")
      @player_rg_constructions.each do |player_construction|
        if player_construction.path_to_power_constructions.first.path_to_power_type == funding_request_params[:construction_resource_ptp_type].downcase
          @funding_request = FundingRequest.new(round:@game.matches.last.rounds.last,construction:player_construction )
         
            if @funding_request.unique_funder_for_turn(@game.players.find_by(house_name:funding_request_params[:player])) && @funding_request.save
              @player_giving_funds=FundingRequestPlayerRole.new(funding_request:@funding_request,player:@game.players.find_by(house_name:funding_request_params[:player]),player_role:"funder")
              @player_accepting_funds=FundingRequestPlayerRole.new(funding_request:@funding_request,player:@player,player_role:"owner")
              if @player_accepting_funds.save && @player_giving_funds.save
                @funding_request_resource=FundingRequestResource.new(funding_request:@funding_request,funding_resource_type:funding_request_params[:resource_type],funding_resource_amount:funding_request_params[:amount])
                if @funding_request_resource.save
                  redirect_to game_page_show_path,  notice: "We await a responce my lord."
                else
                  render :new, status: :unprocessable_entity, notice: "Sorry something went wrong my lord!" 
                end
              else
                @funding_request.destroy
                render :new, status: :unprocessable_entity 
                
              end
            else
              @funding_request.errors.add(funding_request_params[:resource_type],"You have already received resources for this Path to Power from this house or are asking for resources from them now.")
              render :new, status: :unprocessable_entity
              render json: @funding_request.errors, status: :unprocessable_entity 
            end
        
        end
      end
    else
        @funding_request=FundingRequest.new
        if @construction_type=="resource_generator_construction" && funding_request_params[:resource_type].downcase!="gold"
          @funding_request.errors.add(funding_request_params[:resource_type],"Reminder: You cannot pay for resource generators with anything but the kings gold.")
        end
        format.html { render :new, status: :unprocessable_entity}
        format.json { render json: @funding_request.errors, status: :unprocessable_entity }
    end

   
  end

  # PATCH/PUT /funding_requests/1 or /funding_requests/1.json
  def update
    respond_to do |format|
      if @funding_request.update(funding_request_params)
        format.html { redirect_to funding_request_url(@funding_request), notice: "Funding request was successfully updated." }
        format.json { render :show, status: :ok, location: @funding_request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @funding_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /funding_requests/1 or /funding_requests/1.json
  def destroy
   

    respond_to do |format|
      if @funding_request.owner==@player
        @funding_request.destroy
        format.html { redirect_to game_page_show_path, notice:"We shall tell them you no longer need these funds my lord." }
      else
        format.html { redirect_to game_page_show_path, notice:"That is not yours to delete" }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_funding_request
      @funding_request = FundingRequest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def funding_request_params
      params.require(:funding_request).permit(:construction_resource_ptp_type,:player,:amount,:resource_type,)
    end
end