# frozen_string_literal: true

class OdometerReadingsController < ApplicationController
  include Secured
  include Pundit::Authorization
  after_action :verify_authorized

  before_action :set_odometer_reading, only: %i[edit update destroy]

  # GET /odometer_readings/1/edit
  def edit; end

  # POST /odometer_readings or /odometer_readings.json
  def create
    @odometer_reading = OdometerReading.new(create_odometer_reading_params)
    authorize @odometer_reading

    respond_to do |format|
      if @odometer_reading.save
        format.html { redirect_to odometer_vehicle_url(@odometer_reading.vehicle), notice: I18n.t('odometer_reading.create.success') }
        format.json { render :show, status: :created, location: @odometer_reading }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @odometer_reading.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /odometer_readings/1 or /odometer_readings/1.json
  def update
    respond_to do |format|
      if @odometer_reading.update(odometer_reading_params)
        format.html { redirect_to edit_odometer_reading_url(@odometer_reading), notice: I18n.t('odometer_reading.update.success') }
        format.json { render :show, status: :ok, location: @odometer_reading }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @odometer_reading.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /odometer_readings/1 or /odometer_readings/1.json
  def destroy
    @odometer_reading.destroy

    respond_to do |format|
      format.html { redirect_to odometer_readings_url, notice: I18n.t('odometer_reading.destroy.success') }
      format.json { head :no_content }
    end
  end

  def current_navbar_item
    :vehicles
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_odometer_reading
    @odometer_reading = OdometerReading.find(params[:id])
    authorize @odometer_reading
  end

  def transform_performed_at(params)
    params[:performed_at] = convert_from_datetime_field(params[:performed_at])
    params
  end

  # Only allow a list of trusted parameters through.
  def odometer_reading_params
    transform_performed_at(
      params.require(:odometer_reading).permit(:reading, :include_time, :performed_at)
    )
  end

  def create_odometer_reading_params
    transform_performed_at(
      params.require(:odometer_reading).permit(:reading, :include_time, :performed_at, :vehicle_id)
    )
  end
end
