# frozen_string_literal: true

class TireSetsController < ApplicationController
  include Secured
  include Pundit::Authorization
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  before_action :set_tire_set, only: %i[show edit update destroy]

  # GET /tire_sets or /tire_sets.json
  def index
    @tire_sets = policy_scope(TireSet)
  end

  # GET /tire_sets/1 or /tire_sets/1.json
  def show; end

  # GET /tire_sets/new
  def new
    @tire_set = TireSet.new
    authorize @tire_set
  end

  # GET /tire_sets/1/edit
  def edit; end

  # POST /tire_sets or /tire_sets.json
  def create
    @tire_set = TireSet.new(tire_set_params)
    @tire_set.owner = current_user
    authorize @tire_set

    respond_to do |format|
      if @tire_set.save
        format.html { redirect_to tire_set_url(@tire_set), notice: I18n.t('tire_set.create.success') }
        format.json { render :show, status: :created, location: @tire_set }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tire_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tire_sets/1 or /tire_sets/1.json
  def update
    respond_to do |format|
      if @tire_set.update(tire_set_params)
        format.html { redirect_to tire_set_url(@tire_set), notice: I18n.t('tire_set.update.success') }
        format.json { render :show, status: :ok, location: @tire_set }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tire_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tire_sets/1 or /tire_sets/1.json
  def destroy
    @tire_set.destroy

    respond_to do |format|
      format.html { redirect_to tire_sets_url, notice: I18n.t('tire_set.destroy.success') }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tire_set
    @tire_set = TireSet.find(params[:id])
    authorize @tire_set
  end

  # Only allow a list of trusted parameters through.
  def tire_set_params
    params.require(:tire_set).permit(:aspect_ratio, :base_miles, :breakin, :construction, :diameter, :hidden,
                                     :load_index, :make, :model, :speed_rating, :tin, :user_display_name, :vehicle_type, :width)
  end
end
