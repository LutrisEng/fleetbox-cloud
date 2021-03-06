# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user_session, :current_user, :navbar_items, :current_navbar_item, :displayable_time,
                :convert_for_datetime_field

  before_action :authorize_miniprofiler

  rescue_from ActiveRecord::StatementInvalid do |e|
    raise e unless e.cause.is_a?(PG::ReadOnlySqlTransaction)

    r = ENV.fetch('PRIMARY_REGION', nil)
    response.headers['fly-replay'] = "region=#{r}"
    Rails.logger.info "Replaying request in #{r}"
    render plain: "retry in region #{r}", status: :conflict
  end

  def current_user_session
    if Rails.env.test?
      session[:userinfo] ||= {
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
    if current_user_session
      @current_user ||= User.find_or_create_by(email: current_user_session['info']['email']) do |user|
        user.name = current_user_session['info']['name']
      end
      Sentry.add_breadcrumb Sentry::Breadcrumb.new(
        category: 'auth',
        message: "Authenticated user #{@current_user.id} (email #{@current_user.email}) through session (#{current_user_session.as_json})",
        level: 'info'
      )
      Sentry.set_user(id: @current_user.id, email: @current_user.email)
      @current_user
    else
      Sentry.add_breadcrumb Sentry::Breadcrumb.new(
        category: 'auth',
        message: 'Request is missing a session',
        level: 'info'
      )
      Sentry.set_user({})
      nil
    end
  end

  def authorize_miniprofiler
    Rack::MiniProfiler.authorize_request if current_user&.admin
  end

  def navbar_items
    items = [
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
    items.push(id: :admin, href: '/admin') if current_user&.admin
    items
  end

  def current_navbar_item; end

  def displayable_time(time)
    if current_user
      time&.in_time_zone(current_user.tz)
    else
      time&.in_time_zone(Time.zone)
    end
  end

  def convert_for_datetime_field(time)
    displayable_time(time)&.strftime('%Y-%m-%dT%R')
  end

  def convert_from_datetime_field(time)
    if time.is_a?(Time) || time.nil?
      time
    else
      current_user.tz.parse(time)
    end
  end

  def transform_performed_at(params)
    params[:performed_at] = convert_from_datetime_field(params[:performed_at]) if params[:performed_at]
  end

  def authenticate_admin_user!
    if current_user&.admin
      true
    else
      false
    end
  end
end
