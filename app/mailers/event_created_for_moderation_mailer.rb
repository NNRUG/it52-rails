# frozen_string_literal: true

class EventCreatedForModerationMailer < ApplicationMailer
  def new_event_created(admin, event)
    @admin = admin
    @event = event
    headers['Auto-Submitted'] = 'auto-generated'
    mail(
      to: admin.email,
      subject: I18n.t('mailers.event_created_for_moderation.subject', title: event.title)
    )
  end
end
