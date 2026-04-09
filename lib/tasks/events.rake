# frozen_string_literal: true

namespace :events do
  desc 'Update events pageviews from Google Analytics'
  task update_pageviews: :environment do
    UpdateEventPageviews.perform
  end

  desc 'Отправить напоминания участникам о регистрации на мероприятия, которые состоятся завтра'
  task send_reminders: :environment do
    EventRemindersSender.call
  end

  desc 'Отправить в Telegram анонсы мероприятий на ближайшую неделю'
  task send_next_week_to_telegram: :environment do
    SendNextWeekEventsToTelegramJob.perform_later
  end
end
