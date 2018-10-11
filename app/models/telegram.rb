module Telegram
  API_KEY = Figaro.env.telegram_bot_token
  CHAT_ID = Figaro.env.telegram_chat_id
  BASE_URI = 'https://api.telegram.org'

  class ParseError < StandardError; end
  class LongMessageError < StandardError; end
  class Error < StandardError; end
end
