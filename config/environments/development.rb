# frozen_string_literal: true

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :redis_cache_store, { driver: :hiredis,
                                               url: ENV.fetch('REDIS_URL') { 'redis://127.0.0.1:6379' },
                                               expires_in: 10.days,
                                               namespace: :rails_cache,
                                               db: 0 }
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{30.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options)
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true
  config.assets.unknown_asset_fallback = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
  # Письма: основной SMTPS (mail.it52.tech:465), при наличии SMTP_ADDRESS или SMTP_PASSWORD; иначе Яндекс; иначе letter_opener
  smtp_from = ENV.fetch('SMTP_FROM', 'noreply@it52.tech')
  smtp_password = ENV['SMTP_PASSWORD'].to_s.presence
  use_it52_smtp = ENV['SMTP_ADDRESS'].present? || smtp_password.present?

  if use_it52_smtp
    config.action_mailer.default_options = { from: smtp_from }
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: ENV.fetch('SMTP_ADDRESS', 'mail.it52.tech'),
      port: (ENV['SMTP_PORT'] || '465').to_i,
      domain: ENV.fetch('SMTP_DOMAIN', 'it52.tech'),
      tls: true,
      enable_starttls_auto: false,
      user_name: ENV['SMTP_USER_NAME'].presence || smtp_from,
      password: smtp_password,
      authentication: smtp_password.present? ? 'plain' : nil
    }.compact
  elsif ENV['YANDEX_SMTP_USER'].present? && ENV['YANDEX_SMTP_PASSWORD'].present?
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: ENV.fetch('YANDEX_SMTP_ADDRESS', 'smtp.yandex.com'),
      port: (ENV['YANDEX_SMTP_PORT'] || '465').to_i,
      domain: 'yandex.com',
      authentication: 'plain',
      enable_starttls_auto: true,
      user_name: ENV['YANDEX_SMTP_USER'],
      password: ENV['YANDEX_SMTP_PASSWORD']
    }
  else
    config.action_mailer.delivery_method = :letter_opener
  end

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
  config.log_level = :debug

  # Web Console
  config.web_console.whitelisted_ips = ENV.fetch('DOCKER_HOST_IP') { ['::1', '127.0.0.0/8', '172.16.0.0/12'] }
end
