# frozen_string_literal: true

# NOTE:
# `Rails.application.credentials[:production]` may be absent (nil) depending on how credentials
# are structured (single credentials vs environment-specific credentials). We must not crash
# boot/assets:precompile when it's missing.
production_creds = Rails.application.credentials[:production] || {}
production_creds.each { |key, value| ENV[key.to_s] ||= value }

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Ensures that a master key has been made available in either ENV["RAILS_MASTER_KEY"]
  # or in config/master.key. This key is used to decrypt credentials (and other encrypted files).
  config.require_master_key = true

  # OAuth (VK, Google, etc.): set APPLICATION_HOST so callback URL matches what is registered at the provider.
  # Without this, behind a proxy the callback URL can be wrong and authorization fails.
  app_host = ENV.fetch('APPLICATION_HOST', ENV.fetch('mailing_host', 'it52.info')).to_s.strip
  app_host = 'it52.info' if app_host.blank?
  config.action_controller.default_url_options = { host: app_host, protocol: 'https' }
  OmniAuth.config.full_host = "https://#{app_host}"

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :uglifier
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # `config.assets.precompile` and `config.assets.version` have moved to config/initializers/assets.rb

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # Set aws_host only when using a CDN/S3 (e.g. https://storage.yandexcloud.net/your-bucket).
  # When unset, assets are served from the same domain (no broken "aws_host" placeholder).
  config.action_controller.asset_host = ENV['aws_host'].presence

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = 'X-Sendfile' # for Apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for NGINX

  # Store uploaded files on the local file system (see config/storage.yml for options)
  config.active_storage.service = :local

  # Mount Action Cable outside main process or domain
  # config.action_cable.mount_path = nil
  # config.action_cable.url = 'wss://example.com/cable'
  # config.action_cable.allowed_request_origins = [ 'http://example.com', /http:\/\/example.*/ ]

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # Use the lowest log level to ensure availability of diagnostic information
  # when problems arise.
  # config.log_level = :debug

  # Prepend all log lines with the following tags.
  config.log_tags = [:request_id]

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store
  config.cache_store = :redis_cache_store, { driver: :hiredis,
                                             url: ENV.fetch('REDIS_URL') { 'redis://redis:6379' },
                                             expires_in: 60.days,
                                             namespace: :rails_cache,
                                             db: 0 }

  # Use a real queuing backend for Active Job (and separate queues per environment)
  # config.active_job.queue_adapter     = :resque
  # config.active_job.queue_name_prefix = "it52_rails_#{Rails.env}"

  config.action_mailer.perform_caching = false

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Use a different logger for distributed setups.
  # require 'syslog/logger'
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new 'app-name')

  if ENV['RAILS_LOG_TO_STDOUT'].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  host = ENV.fetch('mailing_host', 'it52.info')
  config.action_mailer.default_url_options = { host: host }
  config.action_mailer.default_options = { from: ENV.fetch('YANDEX_SMTP_FROM', 'events@it52.info') }
  config.action_mailer.perform_deliveries = true
  config.action_mailer.logger = ActiveSupport::Logger.new(Rails.root.join('log', 'mailer.log'))
  config.action_mailer.logger.level = Logger::DEBUG

  # Отправка почты через аккаунт Яндекс.Почты (по умолчанию events@it52.info). Учётные данные — из ENV.
  # ENV: YANDEX_SMTP_USER (по умолчанию events@it52.info), YANDEX_SMTP_PASSWORD (пароль приложения).
  yandex_user = ENV['YANDEX_SMTP_USER'].to_s.presence || 'events@it52.info'
  yandex_password = ENV['YANDEX_SMTP_PASSWORD'].to_s.presence

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    tls: true,
    address: ENV.fetch('YANDEX_SMTP_ADDRESS', 'smtp.yandex.com'),
    port: (ENV['YANDEX_SMTP_PORT'] || '465').to_i,
    domain: 'yandex.com',
    authentication: 'plain',
    enable_starttls_auto: true,
    user_name: yandex_user,
    password: yandex_password
  }
end
