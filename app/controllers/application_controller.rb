# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user_session, :current_user

  def current_user_session
    if Rails.env.test?
      session[:userinfo] = {
        'email' => 'mock_test_auth@fleetbox.io',
        'name' => 'Mock Test Auth'
      }
    end
    @current_user_session ||= session[:userinfo]
  end

  def current_user
    return unless current_user_session

    @current_user ||= User.find_or_create_by(email: current_user_session['email']) do |user|
      user.name = current_user_session['name']
    end
  end
end
