# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@fleetbox.io'
  layout 'mailer'
end
