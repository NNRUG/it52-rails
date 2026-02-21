# frozen_string_literal: true

class NotifyAdminsAboutNewEventJob < ApplicationJob
  queue_as :mailers

  def perform(event_id)
    event = Event.find_by(id: event_id)
    return unless event

    User.admins.where.not(email: [nil, '']).find_each do |admin|
      EventCreatedForModerationMailer.new_event_created(admin, event).deliver_later
    end
  end
end
