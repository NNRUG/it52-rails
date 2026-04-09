# frozen_string_literal: true

require 'sidekiq/cron'

REDIS_OPTIONS = { url: ENV.fetch('REDIS_URL') { 'redis://redis:6379' },
                  db: 1 }.freeze

Sidekiq.configure_server do |config|
  config.redis = REDIS_OPTIONS.dup
  config.on(:startup) do
    # Дайджест мероприятий в Telegram — каждое воскресенье в 19:00 (cron: минута час день_месяца месяц день_недели, 0 = вс)
    Sidekiq::Cron::Job.load_from_hash(
      'send_next_week_events_to_telegram' => {
        'class' => 'SendNextWeekEventsToTelegramCronWorker',
        'cron' => '0 19 * * 0',
        'description' => 'Дайджест мероприятий на неделю в Telegram'
      },
      # 06:00 UTC ≈ 09:00 МСК: напоминания о регистрации на мероприятия завтрашнего дня
      'send_event_reminders' => {
        'class' => 'SendEventRemindersCronWorker',
        'cron' => '0 6 * * *',
        'description' => 'Напоминания участникам о мероприятиях на завтра'
      }
    )
  end
end

Sidekiq.configure_client do |config|
  config.redis = REDIS_OPTIONS.dup
end
