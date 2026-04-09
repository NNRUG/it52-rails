# frozen_string_literal: true

# Ежедневная сводка по числу зарегистрировавшихся на предстоящие опубликованные мероприятия организатора.
class OrganizerRegistrationsDigestMailer < ApplicationMailer
  def daily_digest(organizer, event_rows)
    @organizer = organizer
    @event_rows = event_rows
    headers['Auto-Submitted'] = 'auto-generated'
    mail(
      to: organizer.email,
      subject: I18n.t(
        'mailers.organizer_registrations_digest.subject',
        date: I18n.localize(Time.zone.today, format: :default)
      )
    )
  end
end
