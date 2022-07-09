# frozen_string_literal: true

class LogItemsController < ApplicationController
  SET_ACTIONS = %i[show edit update destroy].freeze

  include Secured
  include Pundit::Authorization
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: SET_ACTIONS + %i[index]

  before_action :set_vehicle
  before_action :set_log_item, only: SET_ACTIONS
  before_action :set_shops, only: %i[new create edit update]

  # GET /vehicles/1/log_items or /log_items.json
  def index
    @log_items = @vehicle.log_items.merge(policy_scope(LogItem))
  end

  # GET /vehicles/1/log_items/1 or /log_items/1.json
  def show
    set_log_item_with_includes({ line_items: :line_item_fields })
  end

  # GET /vehicles/1/log_items/new
  def new
    @log_item = LogItem.new(vehicle: @vehicle, performed_at: current_user.now)
    authorize @log_item
  end

  # GET /vehicles/1/log_items/1/edit
  def edit; end

  # POST /vehicles/1/log_items or /vehicles/1/log_items.json
  def create
    @log_item = LogItem.new(log_item_params.except(:odometer_reading_reading))
    @log_item.vehicle = @vehicle
    @log_item.odometer_reading_reading = log_item_params[:odometer_reading_reading]
    authorize @log_item

    respond_to do |format|
      if @log_item.save
        format.html { redirect_to vehicle_log_item_url(@vehicle, @log_item), notice: I18n.t('log_item.create.success') }
        format.json { render :show, status: :created, location: @log_item }
      else
        Rails.logger.debug @log_item.errors.to_json
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
  end

  def set_log_item_with_includes(includes)
    @log_item = policy_scope(LogItem).merge(@vehicle.log_items).includes(includes).find_by(uuid: params[:uuid])
    authorize @log_item
  end

  def set_log_item
    set_log_item_with_includes []
  end

  def set_shops
    @shops = policy_scope(Shop)
    @shop_options = (@shops.map { |shop| [shop.name || shop.uuid || 'Unknown shop', shop.uuid] }) + [['None', nil]]
  end

  # Only allow a list of trusted parameters through.
  def log_item_params
    extracted_params = params.require(:log_item).permit(:display_name, :include_time, :performed_at,
                                                        :odometer_reading_reading, :shop_uuid, :notes)
    transform_performed_at(extracted_params)
    extracted_params
  end
end
