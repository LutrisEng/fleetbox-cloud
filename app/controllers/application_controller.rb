# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user_session, :current_user

  def current_user_session
    @current_user_session ||= session[:userinfo]
  end

  def current_user
    current_user_session
  end
end
