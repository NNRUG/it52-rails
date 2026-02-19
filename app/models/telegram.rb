# frozen_string_literal: true

# Отправка анонсов мероприятий в Telegram-канал (при публикации вызывается SendEventToTelegramJob).
#
# Что нужно сделать:
# 1. Создать бота через @BotFather в Telegram, получить токен.
# 2. Создать канал (или использовать существующий, например @it52info).
# 3. Добавить бота в канал как администратора с правом публиковать сообщения.
# 4. Узнать chat_id канала:
#    - для публичного канала можно использовать @username (например @it52info);
#    - для приватного канала chat_id имеет вид -1001234567890 (узнать можно через getUpdates после поста в канале или через бота @userinfobot / getChat с @channel_username).
# 5. В .env или на сервере задать переменные:
#      telegram_bot_token=123456:ABC-DEF...
#      telegram_chat_id=@it52info
#    (или числовой ID для приватного канала)
# 6. Перезапустить приложение. После публикации мероприятия анонс будет отправляться в канал автоматически.
module Telegram
  API_KEY = ENV.fetch('telegram_bot_token') { 'telegram_bot_token' }
  CHAT_ID = ENV.fetch('telegram_chat_id') { 'telegram_chat_id' }
  BASE_URI = 'https://api.telegram.org'

  class ParseError < StandardError; end
  class LongMessageError < StandardError; end
  class Error < StandardError; end
end
