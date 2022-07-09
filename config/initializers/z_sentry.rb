# frozen_string_literal: true

unless Rails.env.development? || Rails.env.test?
  Sentry.init do |config|
    config.dsn = 'https://4557bc988954437b8f0160de8d5c29aa@o1155807.ingest.sentry.io/6559914'
    config.breadcrumbs_logger = %i[monotonic_active_support_logger http_logger]

    # Set traces_sample_rate to 1.0 to capture 100%
    # of transactions for performance monitoring.
    # We recommend adjusting this value in production.
    config.traces_sample_rate = 1.0

    config.release = FLEETBOX_VERSION
    config.environment = Rails.env
  end
end
