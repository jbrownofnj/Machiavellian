class TradeRequestsController < ApplicationController
  before_action :set_trade_request, only: %i[ show edit update destroy ]
  before_action :set_game,only: [:new,:create,:format_trade_request]
  before_action :set_player,only: [:new,:create,:format_trade_request,:destroy]
  before_action :logged_in?, only:[:index,:show,:new,:edit,:create,:update,:destroy]
  before_action :is_admin?, only:[:index,:show,:edit,:update,:destroy]
  def index
    @trade_requests = TradeRequest.all
  end

  # GET /trade_requests/1 or /trade_requests/1.json
  def show
  end

  # GET /trade_requests/new
  def new
    @trade_request=TradeRequest.new
    @trade_request.trade_player_roles.build
    @number_of_trade_request_resources=params[:number_of_trade_request_resources].to_i+1
   
    @trade_request.trade_request_resources.build
    @trade_request.trade_request_resources.last.trade_request_resource_type="gold"
    
    @trade_request.trade_request_resources.build
    @trade_request.trade_request_resources.last.trade_request_resource_type="spy"
    
    @trade_request.trade_request_resources.build
    @trade_request.trade_request_resources.last.trade_request_resource_type="soldier"
    
    @game.players.each do |player|
      @trade_request.trade_request_resources.build
      @trade_request.trade_request_resources.last.trade_request_resource_type="#{player.house_name} loyalty"
    end
  end


  # GET /trade_requests/1/edit
  def edit
  end

  # POST /trade_requests or /trade_requests.json
  def create
    @trade_request = TradeRequest.new(round:@game.matches.last.rounds.last)

    respond_to do |format|

      if params[:add_trade_resource]
        @trade_request.trade_player_roles.build
        @trade_request.trade_request_resources.build
        trade_request_params[:number_of_resources].to_i.times do 
          @trade_request.trade_request_resources.build
        end
        format.html{render :new, locals:{trade_request:@trade_request}, status: :unprocessable_entity}

      elsif params[:remove_trade_resource]
        @trade_request.trade_player_roles.build
        (trade_request_params[:number_of_resources].to_i-1).times do 
          @trade_request.trade_request_resources.build
        end
        format.html{render :new, status: :unprocessable_entity}

      else
        if @trade_request.save
          if trade_request_params[:role_type] == "sender"
            @sender=TradePlayerRole.new(player:@game.players.where(house_name:trade_request_params[:player]).first, trade_request:@trade_request, role_type:"sender")
            @receiver=TradePlayerRole.new(player:@player,trade_request:@trade_request,role_type:"receiver")
            @creator=TradePlayerRole.new(player:@player,trade_request:@trade_request,role_type:"creator")
          else
            @sender=TradePlayerRole.new(player:@player,trade_request:@trade_request,role_type:"sender")
            @receiver=TradePlayerRole.new(player:@game.players.where(house_name:trade_request_params[:player]).first,trade_request:@trade_request,role_type:"receiver")
            @creator=TradePlayerRole.new(player:@player,trade_request:@trade_request,role_type:"creator")
          end
          if @sender.save && @receiver.save && @creator.save
            @has_at_least_one_resource=false
            trade_request_params[:trade_request_resources_attributes].each do |number_of_resource,params_for_resource|
              if params_for_resource[:trade_request_resource_quantity].to_i>0
                @has_at_least_one_resource=true
                @trade_resource=TradeRequestResource.create(trade_request:@trade_request,trade_request_resource_type:params_for_resource[:trade_request_resource_type],trade_request_resource_quantity:params_for_resource[:trade_request_resource_quantity])
              end
            end
            if @has_at_least_one_resource && (@player.can_afford_trade?(@trade_request)||@player!=@sender.player)
              format.html { redirect_to game_page_show_path, notice: "Awaiting word on your trade my lord" }
            elsif @has_at_least_one_resource
              @trade_request.destroy
              @sender.destroy
              @receiver.destroy
              @creator.destroy
              format.html { redirect_to trade_requests_new_path, notice: "You dont have the resources my lord!" }
            else
              @trade_request.destroy
              @sender.destroy
              @receiver.destroy
              @creator.destroy
              format.html {redirect_to trade_requests_new_path,notice:"One must choose something my lord!"}
            end
          else
            @trade_request.destroy
            @sender.destroy
            @receiver.destroy
            @creator.destroy
            format.html { redirect_to game_page_show_path, notice: "I beleive that trade letter was lost on route sir" }
          end
        else
          format.html { redirect_to game_page_show_path, notice: "I beleive that trade letter was lost on route sir" }
        end
      end
    end
  end
  # PATCH/PUT /trade_requests/1 or /trade_requests/1.json
  def update
    respond_to do |format|
      if @trade_request.update(trade_request_params)
        format.html { redirect_to trade_request_url(@trade_request), notice: "Trade request was successfully updated." }
        format.json { render :show, status: :ok, location: @trade_request }
      else
        
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @trade_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trade_requests/1 or /trade_requests/1.json
  def destroy
    respond_to do |format|
      if @trade_request.creator==@player
        @trade_request.destroy
        format.html { redirect_to game_page_show_path, notice: "We will inform them you no longer wish to trade my lord." }
      else
        format.html { redirect_to game_pages_path, alert: "That is not your trade request to destroy!" }

      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trade_request
      @trade_request = TradeRequest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def trade_request_params
      params.require(:trade_request).permit(:round,:player,:role_type,:number_of_resources, trade_player_roles_attributes:[:role_type,:player],trade_request_resources_attributes:[:trade_request_resource_type,:trade_request_resource_quantity])
    end
  
end
