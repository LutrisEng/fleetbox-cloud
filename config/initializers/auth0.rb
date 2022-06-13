# frozen_string_literal: true

AUTH0_CREDENTIALS = Rails.application.credentials.auth0 || {}

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer if Rails.env.development?
  provider(
    :auth0,
    AUTH0_CREDENTIALS[:client_id],
    AUTH0_CREDENTIALS[:client_secret],
    AUTH0_CREDENTIALS[:domain],
    callback_path: '/auth/auth0/callback',
    authorize_params: {
      scope: 'openid profile email'
    }
  )
end
