# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: -> { ENV.fetch('SMTP_FROM', 'noreply@it52.tech') }
  layout 'mailer'
end
