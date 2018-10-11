module Telegram
  class Message
    require 'json'
    require 'net/http'
    require 'net/http/post/multipart'

    MAX_MESSAGE_LENGTH = 4096
    TYPES_MAP = {
      message: 'sendMessage',
      webhook: 'setWebhook'
    }

    attr_reader :response, :uri, :query, :result

    def initialize(type, chat_id = CHAT_ID)
      raise ArgumentError, "Unknown message type '#{type}'. Acceptable types are #{TYPES_MAP.keys.to_sentence}." unless TYPES_MAP.has_key?(type)

      @query = { chat_id: chat_id }
      @uri = URI "#{BASE_URI}/bot#{API_KEY}/#{TYPES_MAP[type]}"
    end

    def send_message(text)
      @query.merge!({
        text: normalize_text(text),
        parse_mode: 'Markdown'
      })
      post!
    end

    def set_webhook(webhook_url)
      @query = { url: webhook_url }
      post!
    end

    private

    def post!
      @response = Net::HTTP.post_form(@uri, @query)
      @result = JSON.parse(@response.body).to_h
      handle_error() unless @result['ok']
      @result
    end

    def normalize_text(text)
      text.gsub(/\*\*/, '_').gsub(/^\*\s/, '- ').truncate(MAX_MESSAGE_LENGTH, separator: /\s/)
    end

    def handle_error
      klass = LongMessageError if @result['description'] == "Message is too long"
      klass = ParseError if @result['description'] =~ /Can\'t parse message/
      klass ||= Error
      raise klass, @result['description']
    end
  end
end
