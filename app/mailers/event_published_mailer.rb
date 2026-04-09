# frozen_string_literal: true

class EventPublishedMailer < ApplicationMailer
  def published_event_email(user, event)
    @user = user
    @event = event
    headers['List-Unsubscribe'] = "<#{unsubscribe_url(user.signed_id(purpose: :unsubscribe))}>"
    mail(
      to: user.email,
      subject: I18n.t('devise.mailer.event_published.subject', title: event.title)
    )
  end
end
