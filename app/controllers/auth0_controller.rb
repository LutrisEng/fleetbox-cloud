# frozen_string_literal: true

class Auth0Controller < ApplicationController
  skip_before_action :verify_authenticity_token, only: :developer_callback

  def callback
    auth_info = request.env['omniauth.auth']
    session[:userinfo] = auth_info['extra']['raw_info']
    redirect_to '/'
  end

  def developer_callback
    session[:userinfo] = params
    redirect_to '/'
  end

  def failure
    @error_msg = request.params['message']
  end

  def login; end

  def logout
    reset_session
    redirect_to logout_url, allow_other_host: true
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
