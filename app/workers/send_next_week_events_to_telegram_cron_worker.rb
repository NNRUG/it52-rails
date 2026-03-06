# frozen_string_literal: true

# Воркер для sidekiq-cron: по воскресеньям в 19:00 ставит в очередь дайджест мероприятий в Telegram.
class SendNextWeekEventsToTelegramCronWorker
  include Sidekiq::Worker

  sidekiq_options queue: :default

  def perform
    SendNextWeekEventsToTelegramJob.perform_later
  end
end
