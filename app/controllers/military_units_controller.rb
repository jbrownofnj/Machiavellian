class MilitaryUnitsController < ApplicationController
  before_action :set_military_unit, only: %i[ show edit update destroy ]
  before_action :logged_in?, only:[:index,:show,:new,:edit,:create,:update,:destroy]
  before_action :is_admin?, only:[:index,:show,:new,:edit,:create,:update,:destroy]

  # GET /military_units or /military_units.json
  def index
    @military_units = MilitaryUnit.all
  end

  # GET /military_units/1 or /military_units/1.json
  def show
  end

  # GET /military_units/new
  def new
    @military_unit = MilitaryUnit.new
  end

  # GET /military_units/1/edit
  def edit
  end

  # POST /military_units or /military_units.json
  def create
    @military_unit = MilitaryUnit.new(military_unit_params)

    respond_to do |format|
      if @military_unit.save
        format.html { redirect_to military_unit_url(@military_unit), notice: "Military unit was successfully created." }
        format.json { render :show, status: :created, location: @military_unit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @military_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /military_units/1 or /military_units/1.json
  def update
    respond_to do |format|
      if @military_unit.update(military_unit_params)
        format.html { redirect_to military_unit_url(@military_unit), notice: "Military unit was successfully updated." }
        format.json { render :show, status: :ok, location: @military_unit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @military_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /military_units/1 or /military_units/1.json
  def destroy
    @military_unit.destroy

    respond_to do |format|
      format.html { redirect_to military_units_url, notice: "Military unit was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_military_unit
      @military_unit = MilitaryUnit.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def military_unit_params
      params.require(:military_unit).permit(:military_unit_type, :military_unit_power)
    end
end
