# frozen_string_literal: true

class Auth0Controller < ApplicationController
  skip_before_action :verify_authenticity_token, only: :developer_callback

  def callback
    auth_info = request.env['omniauth.auth']
    Rails.logger.debug auth_info
    session[:userinfo] = {
      provider: auth_info[:provider],
      uid: auth_info[:uid],
      info: {
        name: auth_info[:info][:name],
        email: auth_info[:info][:email]
      }
    }
    redirect_to '/'
  end

  def developer_callback
    if Rails.env.development?
      session[:userinfo] = {
        provider: :developer,
        uid: params[:email],
        info: {
          name: params[:name],
          email: params[:email]
        }
      }
    end
    redirect_to '/'
  end

  def failure
    @error_msg = request.params['message']
  end

  def login; end

  def logout
    unless session[:userinfo]
      redirect_to root_path
      return
    end
    provider = session[:userinfo]['provider']
    reset_session
    if provider == 'auth0'
      redirect_to logout_url, allow_other_host: true
    else
      redirect_to root_path
    end
  end

  private

  def logout_url
    request_params = {
      returnTo: root_url,
      client_id: AUTH0_CREDENTIALS[:client_id]
    }
    URI::HTTPS.build(host: AUTH0_CREDENTIALS[:domain], path: '/v2/logout', query: request_params.to_query).to_s
  end
end
