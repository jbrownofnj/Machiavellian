class ConstructionsController < ApplicationController
  before_action :set_construction, only: %i[ show edit update destroy ]
  before_action :set_player, only: [:index,:create]
  before_action :logged_in?, only:[:index,:show,:edit,:new,:create,:update,:destroy]
  before_action :is_admin?, only:[:show,:edit,:update,:destroy]
  
  # GET /constructions or /constructions.json
  def index
    @constructions = @player.constructions
  end

  # GET /constructions/1 or /constructions/1.json
  def show
  end

  # GET /constructions/new
  def new
    @construction = Construction.new
  end

  # GET /constructions/1/edit
  def edit
  end

  # POST /constructions or /constructions.json
  def create
    @construction = Construction.new(construction_params)
    @is_unique_type=true
    @player.constructions&.each do |construction|
      if construction.construction_type == @construction.construction_type && construction.is_funded != false
        @is_unique_type=false
      end
    end
    
    respond_to do |format|
      if @is_unique_type && @construction.save
        format.html { redirect_to construction_url(@construction), notice: "We shall begin work at once my lord!" }
        format.json { render :show, status: :created, location: @construction }
      else
        format.html { render :new, status: :unprocessable_entity, notice:"Sorry my lord the work has hit a snag." }
        format.json { render json: @construction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /constructions/1 or /constructions/1.json
  def update
    respond_to do |format|
      if @construction.update(construction_params)
        format.html { redirect_to construction_url(@construction), notice: "Construction was successfully updated." }
        format.json { render :show, status: :ok, location: @construction }
      else
        format.html {render :edit, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /constructions/1 or /constructions/1.json
  def destroy
    @construction.destroy

    respond_to do |format|
      format.html { redirect_to constructions_url, notice: "That construction will bother you no more sir." }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_construction
      @construction = Construction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def construction_params
      params.require(:construction).permit(:player_id, :construction_type)
    end
end
