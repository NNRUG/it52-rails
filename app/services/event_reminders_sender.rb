# frozen_string_literal: true

# Рассылка напоминаний зарегистрированным участникам о мероприятиях на завтра.
# Вызывается из rake events:send_reminders и из Sidekiq-cron.
class EventRemindersSender
  def self.call
    Event.published.starting_tomorrow.find_each do |event|
      event.participants.find_each do |user|
        next if user.email.blank?

        EventReminderMailer.reminder_email(user, event).deliver_later
      end
    end
  end
end
