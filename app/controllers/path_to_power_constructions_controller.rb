class PathToPowerConstructionsController < ApplicationController
  before_action :set_path_to_power_construction, only: %i[ show edit update destroy ]
  before_action :set_player,only: [:create]
  before_action :set_game,only: [:create]
  before_action :logged_in?, only:[:index,:show,:new,:edit,:create,:update,:destroy]
  before_action :is_admin?, only:[:index,:show,:edit,:update,:destroy]
  # GET /path_to_power_constructions or /path_to_power_constructions.json
  def index
    @path_to_power_constructions = PathToPowerConstruction.all
  end

  # GET /path_to_power_constructions/1 or /path_to_power_constructions/1.json
  def show
  end

  # GET /path_to_power_constructions/new
  def new
    @path_to_power_construction = PathToPowerConstruction.new
  end

  # GET /path_to_power_constructions/1/edit
  def edit
  end

  # POST /path_to_power_constructions or /path_to_power_constructions.json
  def create
    @construction=Construction.new(construction_type:"path_to_power_construction",player:@player,round:@game.matches.last.rounds.last)
    if @construction.save
      @path_to_power_construction=PathToPowerConstruction.new(construction:@construction,path_to_power_type:path_to_power_construction_params[:path_to_power_type])
      if @path_to_power_construction.save
        redirect_to game_page_show_path
      else
        @construction.destroy
        flash[:alert]=@path_to_power_construction.errors
        flash[:notice]="Your path to power has failed!"
        redirect_to new_construction_path
      end
    else
      if @construction.errors.where(attribute="construction_type")
        flash[:notice]="Sorry but you already have a Path to Power being built!"
      else
        flash[:alert]=@construction.errors
        flash[:notice]="Your construction has failed!"
      end
      
      redirect_to new_construction_path
    end
  end

  # PATCH/PUT /path_to_power_constructions/1 or /path_to_power_constructions/1.json
  def update
    respond_to do |format|
      if @path_to_power_construction.update(path_to_power_construction_params)
        format.html { redirect_to path_to_power_construction_url(@path_to_power_construction), notice: "Path to power construction was successfully updated." }
        format.json { render :show, status: :ok, location: @path_to_power_construction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @path_to_power_construction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /path_to_power_constructions/1 or /path_to_power_constructions/1.json
  def destroy
    @path_to_power_construction.destroy

    respond_to do |format|
      format.html { redirect_to path_to_power_constructions_url, notice: "Path to power construction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_path_to_power_construction
      @path_to_power_construction = PathToPowerConstruction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def path_to_power_construction_params
      params.require(:path_to_power_construction).permit(:path_to_power_type)
    end
end
