# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: -> { ENV.fetch('SMTP_FROM', 'noreply@it52.tech') }
  default reply_to: -> { ENV['SMTP_REPLY_TO'].presence }
  layout 'mailer'
end
