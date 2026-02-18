# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: -> { ENV.fetch('YANDEX_SMTP_FROM', 'events@it52.info') }
  layout 'mailer'
end
