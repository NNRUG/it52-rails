# frozen_string_literal: true

class EventReminderMailer < ApplicationMailer
  def reminder_email(user, event)
    @user = user
    @event = event
    mail(
      to: user.email,
      subject: I18n.t('devise.mailer.reminder.subject', title: event.title)
    )
  end
end
