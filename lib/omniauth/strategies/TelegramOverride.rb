# frozen_string_literal: true
#
require 'omniauth'
require 'omniauth/strategies/telegram'
require 'base64'
require 'openssl'
require 'slim'
module OmniAuth
  module Strategies 
    class TelegramOverride < OmniAuth::Strategies::Telegram
      include OmniAuth::Strategy

      args [:bot_name, :bot_secret]

      option :name, 'telegram'
      option :bot_name, nil
      option :bot_secret, nil
      option :button_config, {}

      REQUIRED_FIELDS = %w[id hash]
      HASH_FIELDS     = %w[auth_date first_name id last_name photo_url username]
 
      def request_phase
        #auto_click = "<script nonce=\"6mUbPI0twoYW486TkqEDCA==\">
        #document.addEventListener('DOMContentLoaded', function() {console.log(\"test\");})
          
        #</script>"
        data_attrs = options.button_config.map { |k,v| "data-#{k}=\"#{v}\"" }.join(" ")
        
        html = ApplicationController.render('devise/omniauth/telegram', layout: false, assigns: {
          options: options,
          callback_url: callback_url,
          data_attrs: data_attrs
        })
        #html = <<-HTML
        #  <!DOCTYPE html>
        #  <html>
        #  <head>
        #    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        #    <title>Telegram Login</title>
        #  </head>
        #  <body>
        #  #{auto_click}
        #  <script async
        #      src=\"https://telegram.org/js/telegram-widget.js?4\"
        #      data-telegram-login=\"#{options.bot_name}\"
        #      data-auth-url=\"#{callback_url}\"
        #      #{data_attrs}></script>
        #    </body>
        #    </html>
        #HTML
    
        Rack::Response.new(html, 200, 'content-type' => 'text/html').finish
      end
      #OmniAuth.config.add_camelization 'telegram', 'TelegramOverride'
    end
  end
end
