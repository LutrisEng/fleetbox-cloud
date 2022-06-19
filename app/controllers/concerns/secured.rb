# frozen_string_literal: true

module Secured
  extend ActiveSupport::Concern

  included do
    before_action :logged_in_using_omniauth?
  end

  def logged_in_using_omniauth?
    redirect_to '/login', alert: I18n.t(:not_logged_in_error) if current_user.blank?
  end
end
