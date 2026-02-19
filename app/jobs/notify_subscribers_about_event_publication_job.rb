# frozen_string_literal: true

class NotifySubscribersAboutEventPublicationJob < ApplicationJob
  queue_as :mailers

  def perform(event_id)
    event = Event.find_by(id: event_id)
    return unless event&.published?

    category_ids = event.category_ids
    return if category_ids.blank?

    User
      .subscribed
      .interested_in_categories(category_ids)
      .where.not(id: event.organizer_id)
      .where.not(email: [nil, ''])
      .find_each do |user|
        EventPublishedMailer.published_event_email(user, event).deliver_later
      end
  end
end
