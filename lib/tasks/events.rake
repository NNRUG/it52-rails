# frozen_string_literal: true

namespace :events do
  desc 'Update events pageviews from Google Analytics'
  task update_pageviews: :environment do
    UpdateEventPageviews.perform
  end

  desc 'Отправить напоминания участникам мероприятий, которые начинаются через 2 дня'
  task send_reminders: :environment do
    events = Event.published.starting_in_2_days
    events.find_each do |event|
      event.participants.find_each do |user|
        next if user.email.blank?

        EventReminderMailer.reminder_email(user, event).deliver_later
      end
    end
  end

  desc 'Отправить в Telegram анонсы мероприятий на ближайшую неделю'
  task send_next_week_to_telegram: :environment do
    SendNextWeekEventsToTelegramJob.perform_later
  end
end
