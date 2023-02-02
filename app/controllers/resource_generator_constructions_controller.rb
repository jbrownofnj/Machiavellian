class ResourceGeneratorConstructionsController < ApplicationController
  before_action :set_resource_generator_construction, only: %i[ show edit update destroy ]
  before_action :set_player,only: [:create]
  before_action :set_game,only: [:create]
  before_action :logged_in?, only:[:index,:show,:new,:edit,:create,:update,:destroy]
  before_action :is_admin?, only:[:index,:show,:new,:edit,:update,:destroy]
  # GET /resource_generator_constructions or /resource_generator_constructions.json
  def index
    @resource_generator_constructions = ResourceGeneratorConstruction.all
  end

  # GET /resource_generator_constructions/1 or /resource_generator_constructions/1.json
  def show
  end

  # GET /resource_generator_constructions/new
  def new
    @resource_generator_construction = ResourceGeneratorConstruction.new
  end

  # GET /resource_generator_constructions/1/edit
  def edit
  end

  # POST /resource_generator_constructions or /resource_generator_constructions.json
  def create
    @construction=Construction.new(construction_type:"resource_generator_construction",player:@player,round:@game.matches.last.rounds.last)
    
    if @construction.save
      @resource_generator_construction=ResourceGeneratorConstruction.new(construction:@construction,resource_generator_type:resource_generator_construction_params[:resource_generator_type].downcase)
      if @resource_generator_construction.save
        redirect_to game_page_show_path
      else
        @construction.destroy
        flash[:alert]=@resource_generator_construction.errors
        flash[:notice]="errors due to resource_generator_construction"
        redirect_to new_construction_path
      end
    else
      if @construction.errors.where(attribute="construction_type")
        flash[:notice]="Sorry but you already have a Resource Generator being built!"
      else
        flash[:alert]=@construction.errors
        flash[:notice]="Your construction has failed!"
      end
      redirect_to new_construction_path
    end
  end

  # PATCH/PUT /resource_generator_constructions/1 or /resource_generator_constructions/1.json
  def update
    respond_to do |format|
      if @resource_generator_construction.update(resource_generator_construction_params)
        format.html { redirect_to resource_generator_construction_url(@resource_generator_construction), notice: "Resource generator construction was successfully updated." }
        format.json { render :show, status: :ok, location: @resource_generator_construction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @resource_generator_construction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resource_generator_constructions/1 or /resource_generator_constructions/1.json
  def destroy
    @resource_generator_construction.destroy

    respond_to do |format|
      format.html { redirect_to resource_generator_constructions_url, notice: "Resource generator construction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resource_generator_construction
      @resource_generator_construction = ResourceGeneratorConstruction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def resource_generator_construction_params
      params.require(:resource_generator_construction).permit(:resource_generator_type)
    end
end
