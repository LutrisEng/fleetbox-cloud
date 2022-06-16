# frozen_string_literal: true

class OdometerReadingsController < ApplicationController
  SET_ACTIONS = %i[edit update destroy].freeze

  include Secured
  include Pundit::Authorization
  after_action :verify_authorized
  after_action :verify_policy_scoped, only: SET_ACTIONS + %i[index]

  before_action :set_vehicle
  before_action :set_odometer_reading, only: SET_ACTIONS

  # GET /vehicles/1/odometer_readings or /vehicles/1/odometer_readings.json
  def index
    @odometer_reading = OdometerReading.new(vehicle: @vehicle, performed_at: current_user.now) if policy(@vehicle).edit?
    @odometer_readings = policy_scope(OdometerReading).merge(@vehicle.odometer_readings)
  end

  # GET /vehicles/1/odometer_readings/1/edit
  def edit; end

  # POST /vehicles/1/odometer_readings or /vehicles/1/odometer_readings.json
  def create
    @odometer_reading = OdometerReading.new(odometer_reading_params)
    @odometer_reading.vehicle = @vehicle
    authorize @odometer_reading

    respond_to do |format|
      if @odometer_reading.save
        format.html do
          redirect_to vehicle_odometer_readings_url(@odometer_reading.vehicle),
                      notice: I18n.t('odometer_reading.create.success')
        end
        format.json { render :show, status: :created, location: @odometer_reading }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @odometer_reading.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vehicles/1/odometer_readings/1 or /vehicles/1/odometer_readings/1.json
  def update
    respond_to do |format|
      if @odometer_reading.update(odometer_reading_params)
        format.html do
          redirect_to edit_vehicle_odometer_reading_url(@vehicle, @odometer_reading),
                      notice: I18n.t('odometer_reading.update.success')
        end
        format.json { render :show, status: :ok, location: @odometer_reading }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @odometer_reading.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vehicles/1/odometer_readings/1 or /vehicles/1/odometer_readings/1.json
  def destroy
    @odometer_reading.destroy

    respond_to do |format|
      format.html do
        redirect_to vehicle_odometer_readings_url(@vehicle), notice: I18n.t('odometer_reading.destroy.success')
      end
      format.json { head :no_content }
    end
  end

  def current_navbar_item
    :vehicles
  end

  private

  def set_vehicle
    @vehicle = policy_scope(Vehicle).find_by(uuid: params[:vehicle_uuid])
    authorize @vehicle
  end

  def set_odometer_reading
    @odometer_reading = policy_scope(OdometerReading).merge(@vehicle.odometer_readings).find_by(uuid: params[:uuid])
    authorize @odometer_reading
  end

  # Only allow a list of trusted parameters through.
  def odometer_reading_params
    extracted_params = params.require(:odometer_reading).permit(:reading, :include_time, :performed_at)
    transform_performed_at(extracted_params)
    extracted_params
  end
end
