class ResourceGeneratorsController < ApplicationController
  before_action :set_resource_generator, only: %i[ show edit update destroy ]
  before_action :logged_in?, only:[:index,:show,:new,:edit,:create,:update,:destroy]
  before_action :is_admin?, only:[:index,:show,:new,:edit,:create,:update,:destroy]
  # GET /resource_generators or /resource_generators.json
  def index
    @resource_generators = ResourceGenerator.all
  end

  # GET /resource_generators/1 or /resource_generators/1.json
  def show
  end

  # GET /resource_generators/new
  def new
    @resource_generator = ResourceGenerator.new
  end

  # GET /resource_generators/1/edit
  def edit
  end

  # POST /resource_generators or /resource_generators.json
  def create
    @resource_generator = ResourceGenerator.new(resource_generator_params)

    respond_to do |format|
      if @resource_generator.save
        format.html { redirect_to resource_generator_url(@resource_generator), notice: "Resource generator was successfully created." }
        format.json { render :show, status: :created, location: @resource_generator }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @resource_generator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /resource_generators/1 or /resource_generators/1.json
  def update
    respond_to do |format|
      if @resource_generator.update(resource_generator_params)
        format.html { redirect_to resource_generator_url(@resource_generator), notice: "Resource generator was successfully updated." }
        format.json { render :show, status: :ok, location: @resource_generator }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @resource_generator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resource_generators/1 or /resource_generators/1.json
  def destroy
    @resource_generator.destroy

    respond_to do |format|
      format.html { redirect_to resource_generators_url, notice: "Resource generator was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resource_generator
      @resource_generator = ResourceGenerator.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def resource_generator_params
      params.require(:resource_generator).permit(:player_id, :resource_generator_type)
    end
end
