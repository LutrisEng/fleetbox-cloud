# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user_session, :current_user, :navbar_items, :current_navbar_item, :displayable_time,
                :display_time, :convert_for_datetime_field

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

  def displayable_time(time)
    if current_user
      time.in_time_zone(current_user.tz)
    else
      time.in_time_zone(Time.zone)
    end
  end

  def display_time(time, **options)
    I18n.l(displayable_time(time), **options)
  end

  def convert_for_datetime_field(time)
    displayable_time(time).strftime('%Y-%m-%dT%R')
  end

  def convert_from_datetime_field(time)
    if time.is_a?(Time)
      time
    else
      current_user.tz.parse(time)
    end
  end
end
