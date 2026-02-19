# frozen_string_literal: true

# Отправляет анонс мероприятия в Telegram-канал после публикации.
# Требуется: ENV['telegram_bot_token'], ENV['telegram_chat_id'], бот добавлен в канал как админ.
class SendEventToTelegramJob < ApplicationJob
  queue_as :default

  def perform(event_id)
    event = Event.find_by(id: event_id)
    return unless event&.published?

    event.send_to_telegram
  end
end
