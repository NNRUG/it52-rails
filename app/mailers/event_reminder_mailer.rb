# frozen_string_literal: true

class EventReminderMailer < ApplicationMailer
  def reminder_email(user, event)
    @user = user
    @event = event
    headers['List-Unsubscribe'] = "<#{unsubscribe_url(user.signed_id(purpose: :unsubscribe))}>"
    mail(
      to: user.email,
      subject: I18n.t('devise.mailer.reminder.subject', title: event.title)
    )
  end
end
