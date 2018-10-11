class TelegramHooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  after_action :track_bot_request

  def process_bot_request
    @req = Telegram::Request.new bot_request_params
    @req.reply!
  rescue NoMethodError => e
    Rails.logger.error 'Something went wrong'
  ensure
    render nothing: true, status: :ok
  end

  private

  def track_bot_request
    token = Figaro.env.botan_token
    message = { text: @req.text }
    action = if @req.action
      @req.action.first
    else
      'Unkown'
    end
    puts Telegram::Botan.track(token, @req.user_id, message, action)
  rescue StandardError => e
    puts e.message
  end

  def bot_request_params
    params.permit!
  end
end
