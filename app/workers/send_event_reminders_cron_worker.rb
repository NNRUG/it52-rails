# frozen_string_literal: true

# Sidekiq-cron: ежедневная рассылка напоминаний участникам о мероприятиях на завтра.
class SendEventRemindersCronWorker
  include Sidekiq::Worker

  sidekiq_options queue: :default

  def perform
    EventRemindersSender.call
  end
end
