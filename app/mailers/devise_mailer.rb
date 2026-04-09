# frozen_string_literal: true

# Единый layout и отправитель для писем Devise (подтверждение, сброс пароля и т.д.)
class DeviseMailer < Devise::Mailer
  layout 'mailer'
  default from: -> { ENV.fetch('SMTP_FROM', 'noreply@it52.tech') }
  default reply_to: -> { ENV['SMTP_REPLY_TO'].presence }
end
