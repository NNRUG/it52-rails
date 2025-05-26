# frozen_string_literal: true
#
require 'omniauth'
require 'omniauth/strategies/telegram'
require 'base64'
require 'openssl'
require 'slim'
class TelegramOverride < OmniAuth::Strategies::Telegram
      include OmniAuth::Strategy

      args [:bot_name, :bot_secret]

      option :name, 'telegram'
      option :bot_secret, nil

      REQUIRED_FIELDS = %w[id hash]
      HASH_FIELDS     = %w[auth_date first_name id last_name photo_url username]
 
      def request_phase
        request = ActionDispatch::Request.new(env)
        csp_nonce = request.content_security_policy_nonce

        bot_id = options.bot_secret.partition(':').first

        html = ApplicationController.render('devise/omniauth/telegram_oauth', layout: false, locals: {
          csp_nonce: csp_nonce,
          bot_id: bot_id,
          callback_url: callback_url
        })
    
        Rack::Response.new(html, 200, 'content-type' => 'text/html').finish
      end

      def to_s
        'Telegram'
      end
      OmniAuth.config.add_camelization 'telegram', 'TelegramOverride'
end