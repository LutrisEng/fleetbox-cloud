# frozen_string_literal: true

class VehiclesController < ApplicationController
  SET_ACTIONS = %i[show edit update destroy].freeze

  include Secured
  include Pundit::Authorization
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: SET_ACTIONS + %i[index]

  before_action :set_vehicle, only: SET_ACTIONS

  # GET /vehicles or /vehicles.json
  def index
    @vehicles = policy_scope(Vehicle).includes(:photo_attachment, :owner)
  end

  # GET /vehicles/1 or /vehicles/1.json
  def show; end

  # GET /vehicles/new
  def new
    @vehicle = Vehicle.new
    authorize @vehicle
  end

  # GET /vehicles/1/edit
  def edit; end

  # POST /vehicles or /vehicles.json
  def create
    @vehicle = Vehicle.new(vehicle_params)
    @vehicle.owner = current_user
    authorize @vehicle

    respond_to do |format|
      if @vehicle.save
        format.html { redirect_to vehicle_url(@vehicle), notice: I18n.t('vehicle.create.success') }
        format.json { render :show, status: :created, location: @vehicle }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vehicles/1 or /vehicles/1.json
  def update
    respond_to do |format|
      if @vehicle.update(vehicle_params)
        format.html { redirect_to vehicle_url(@vehicle), notice: I18n.t('vehicle.update.success') }
        format.json { render :show, status: :ok, location: @vehicle }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vehicles/1 or /vehicles/1.json
  def destroy
    @vehicle.destroy

    respond_to do |format|
      format.html { redirect_to vehicles_url, notice: I18n.t('vehicle.destroy.success') }
      format.json { head :no_content }
    end
  end

  def current_navbar_item
    :vehicles
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_vehicle
    @vehicle = policy_scope(Vehicle).find_by(uuid: params[:uuid])
    authorize @vehicle
  end

  # Only allow a list of trusted parameters through.
  def vehicle_params
    params.require(:vehicle).permit(:breakin, :user_display_name, :make, :miles_per_year,
                                    :model, :vin, :model_year, :photo, :remove_photo)
  end
end
