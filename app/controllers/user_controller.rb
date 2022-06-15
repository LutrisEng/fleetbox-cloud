# frozen_string_literal: true

class UserController < ApplicationController
  include Secured
  include Pundit::Authorization
  after_action :verify_authorized
  before_action :set_user

  def me; end

  def update_me
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url, notice: I18n.t('user.update.success') }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_user
    @user = current_user
    authorize @user
  end

  def user_params
    params.require(:user).permit(:name, :timezone)
  end
end
