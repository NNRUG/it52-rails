# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module It52Rails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.autoloader = :zeitwerk

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Europe/Moscow'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.available_locales = [:ru]
    config.i18n.default_locale = :ru

    config.responders.flash_keys = %i[success error]

    # Add concerns to autoload
    config.autoload_paths += %w[app/uploaders/concerns app/services lib].map { |path| Rails.root.join(path) }
    config.eager_load_paths << Rails.root.join('lib')

    # Use a real queuing backend for Active Job (and separate queues per environment)
    config.active_job.queue_adapter = :sidekiq
    config.active_job.queue_name_prefix = "it52.#{Rails.env}"
    config.active_job.queue_name_delimiter = '.'

    # Mailing host
    config.action_mailer.default_url_options = { host: ENV.fetch('mailing_host') { 'it52.info' } }
    config.action_mailer.default_options = { from: "events@#{ENV.fetch('mailing_host') { 'it52.info' }}" }
    config.action_mailer.smtp_settings = {}
    config.action_mailer.delivery_method = :letter_opener

    # Middleware
    config.middleware.insert_after ActionDispatch::Static, Rack::Deflater
  end
end
