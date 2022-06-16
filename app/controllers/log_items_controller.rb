# frozen_string_literal: true

class LogItemsController < ApplicationController
  SET_ACTIONS = %i[show edit update destroy].freeze

  include Secured
  include Pundit::Authorization
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: SET_ACTIONS + %i[index]

  before_action :set_vehicle
  before_action :set_log_item, only: SET_ACTIONS

  # GET /vehicles/1/log_items or /log_items.json
  def index
    @log_items = @vehicle.log_items.merge(policy_scope(LogItem))
  end

  # GET /vehicles/1/log_items/1 or /log_items/1.json
  def show; end

  # GET /vehicles/1/log_items/new
  def new
    @log_item = LogItem.new(vehicle: @vehicle, performed_at: current_user.now)
    authorize @log_item
  end

  # GET /vehicles/1/log_items/1/edit
  def edit; end

  # POST /vehicles/1/log_items or /vehicles/1/log_items.json
  def create
    @log_item = LogItem.new(log_item_params)
    @log_item.vehicle = @vehicle
    authorize @log_item

    respond_to do |format|
      if @log_item.save
        format.html { redirect_to vehicle_log_item_url(@vehicle, @log_item), notice: I18n.t('log_item.create.success') }
        format.json { render :show, status: :created, location: @log_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @log_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vehicles/1/log_items/1 or /vehicles/1/log_items/1.json
  def update
    respond_to do |format|
      if @log_item.update(log_item_params)
        format.html { redirect_to vehicle_log_item_url(@vehicle, @log_item), notice: I18n.t('log_item.update.success') }
        format.json { render :show, status: :ok, location: @log_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @log_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vehicles/1/log_items/1 or /vehicles/1/log_items/1.json
  def destroy
    @log_item.destroy

    respond_to do |format|
      format.html { redirect_to vehicle_log_items_url(@vehicle), notice: I18n.t('log_item.destroy.success') }
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

  def set_log_item
    @log_item = policy_scope(LogItem).merge(@vehicle.log_items).find_by(uuid: params[:uuid])
    authorize @log_item
  end

  # Only allow a list of trusted parameters through.
  def log_item_params
    extracted_params = params.require(:log_item).permit(:display_name, :include_time, :performed_at,
                                                        :odometer_reading_reading)
    transform_performed_at(extracted_params)
    extracted_params
  end
end
