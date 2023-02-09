class GatherInformationsController < ApplicationController
  before_action :set_game, only: [:new,:create]
  before_action :set_player, only: [:new,:create]
  before_action :is_admin?, only:[:index,:edit,:update,:destroy]
  before_action :logged_in?, only:[:index,:show,:edit,:new,:create,:update,:destroy]
  # GET /gather_informations or /gather_informations.json
  def index
    @gather_informations = GatherInformation.all
  end

  # GET /gather_informations/1 or /gather_informations/1.json
  def show
    @gather_information=GatherInformation.find(params[:id])
  end

  # GET /gather_informations/new
  def new
    @gather_information = GatherInformation.new
    @round=@game.current_round
  end

  # GET /gather_informations/1/edit
  def edit
  end

  # POST /gather_informations or /gather_informations.json
  def create
    @player_action=PlayerAction.new(player:@player,round:@game.current_round,action_type:"gather_information")
    @cost_to_learn=@player.cost_to_gather_information(@game.current_round)
    @has_enough_spies= @player.amount_of_resource("spy")>=@cost_to_learn
    @target_player=Player.find_by(id:gather_information_params[:player_id].to_i)
    respond_to do |format|
      if @has_enough_spies && @target_player && @player_action.save 
        
        @player.lose_resource("spy",@cost_to_learn)
        @gather_information = GatherInformation.new(player_action:@player_action,information_type:gather_information_params[:information_type],player:@target_player)
        if @gather_information.save
          if @gather_information.information_type=="military_information"
            @player_military_unit_roles = @target_player.player_military_unit_roles
            @player=@target_player
            format.html { render :template=> "player_military_unit_roles/index", status: :unprocessable_entity }
          elsif @gather_information.information_type=="resources"
            @player_military_unit_roles = @target_player.player_military_unit_roles
            @player=@target_player
            @player_resources = @player.player_resources
            @player_loyalty_roles = @player.player_loyalty_roles.where(player_loyalty_role_type:"holder")
            @resource_generators=@player.resource_generators
            format.html { render :template=> "player_resources/index", status: :unprocessable_entity }
          elsif @gather_information.information_type=="trades"
            format.html { redirect_to gather_information_url(@gather_information), notice: "Gather information was successfully created." }
          end
        else
          @gather_information=GatherInformation.new
          format.html { render :new, status: :unprocessable_entity }
        end
      else
        if @target_player
          flash[:notice]="Looks like you dont have enough spies or have already gathered information this round already."
        else
          flash[:notice]="You must select a player."
        end
        @gather_information=GatherInformation.new
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gather_informations/1 or /gather_informations/1.json
  def update
    respond_to do |format|
      if @gather_information.update(gather_information_params)
        format.html { redirect_to gather_information_url(@gather_information), notice: "Gather information was successfully updated." }
        format.json { render :show, status: :ok, location: @gather_information }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @gather_information.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gather_informations/1 or /gather_informations/1.json
  def destroy
    @gather_information.destroy

    respond_to do |format|
      format.html { redirect_to gather_informations_url, notice: "Gather information was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gather_information
      @gather_information = GatherInformation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def gather_information_params
      params.require(:gather_information).permit(:player_action_id, :information_type,:player_id)
    end
end