# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user_session, :current_user, :navbar_items, :current_navbar_item

  def current_user_session
    if Rails.env.test? && @current_user_session.nil?
      session[:userinfo] = {
        'provider' => :developer,
        'uid' => 'mock_test_auth@fleetbox.io',
        'info' => {
          'name' => 'Mock Test Auth',
          'email' => 'mock_test_auth@fleetbox.io'
        }
      }
    end
    @current_user_session ||= session[:userinfo]
  end

  def current_user
    return unless current_user_session

    @current_user ||= User.find_or_create_by(email: current_user_session['info']['email']) do |user|
      user.name = current_user_session['info']['email']
    end
  end

  def navbar_items
    [
      {
        id: :vehicles,
        href: vehicles_path
      },
      {
        id: :shops,
        href: '#'
      },
      {
        id: :tire_sets,
        href: tire_sets_path
      }
    ]
  end

  def current_navbar_item; end
end
