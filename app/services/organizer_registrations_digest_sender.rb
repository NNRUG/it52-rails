# frozen_string_literal: true

# Рассылает организаторам ежедневную сводку по регистрациям на их предстоящие опубликованные мероприятия.
class OrganizerRegistrationsDigestSender
  def self.call
    organizer_ids = Event.published.future_excluding_today.distinct.pluck(:organizer_id)
    return if organizer_ids.empty?

    User.where(id: organizer_ids).find_each do |organizer|
      next if organizer.email.blank?

      events = Event.published.future_excluding_today.where(organizer_id: organizer.id).order(:started_at)
      next if events.empty?

      event_ids = events.pluck(:id)
      counts = EventParticipation.where(event_id: event_ids).group(:event_id).count
      event_rows = events.map { |e| { event: e, count: counts[e.id].to_i } }

      OrganizerRegistrationsDigestMailer.daily_digest(organizer, event_rows).deliver_later
    end
  end
end
