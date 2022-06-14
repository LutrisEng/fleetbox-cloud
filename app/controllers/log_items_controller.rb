# frozen_string_literal: true

class LogItemsController < ApplicationController
  include Secured
  include Pundit::Authorization
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  before_action :set_log_item, only: %i[show edit update destroy]

  # GET /log_items or /log_items.json
  def index
    @log_items = policy_scope(LogItem)
  end

  # GET /log_items/1 or /log_items/1.json
  def show; end

  # GET /log_items/new
  def new
    @log_item = LogItem.new
    authorize @log_item
  end

  # GET /log_items/1/edit
  def edit; end

  # POST /log_items or /log_items.json
  def create
    @log_item = LogItem.new(create_log_item_params)
    authorize @log_item

    respond_to do |format|
      if @log_item.save
        format.html { redirect_to log_item_url(@log_item), notice: I18n.t('log_item.create.success') }
        format.json { render :show, status: :created, location: @log_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @log_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /log_items/1 or /log_items/1.json
  def update
    respond_to do |format|
      if @log_item.update(log_item_params)
        format.html { redirect_to log_item_url(@log_item), notice: I18n.t('log_item.update.success') }
        format.json { render :show, status: :ok, location: @log_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @log_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /log_items/1 or /log_items/1.json
  def destroy
    @log_item.destroy

    respond_to do |format|
      format.html { redirect_to log_items_url, notice: I18n.t('log_item.destroy.success') }
      format.json { head :no_content }
    end
  end

  def current_navbar_item
    :vehicles
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_log_item
    @log_item = LogItem.find(params[:id])
    authorize @log_item
  end

  # Only allow a list of trusted parameters through.
  def log_item_params
    params.require(:log_item).permit(:display_name, :include_time, :performed_at)
  end

  def create_log_item_params
    params.require(:log_item).permit(:display_name, :include_time, :performed_at, :vehicle_id)
  end
end
