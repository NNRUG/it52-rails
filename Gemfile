# frozen_string_literal: true

ruby '2.6.5'

source 'https://rubygems.org'

gem 'bootsnap'
gem 'rails', '~> 5.2.0'

# Databases
gem 'hiredis'
gem 'pg'
gem 'redis'

# Queue
gem 'sidekiq'

# Integrations
gem 'http'
gem 'mailchimp-api', require: 'mailchimp'
gem 'mailgun_rails'

# Normalization and locales
gem 'postrank-uri'
gem 'rails-i18n'
gem 'unicode'

# Authentication and authorization
gem 'cancancan'
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-github'
gem 'omniauth-google-oauth2'
gem 'omniauth-twitter'
gem 'omniauth-vkontakte'

# Request handling
gem 'friendly_id'
gem 'has_scope'

# Decoration
gem 'active_model_serializers'
gem 'activemodel-serializers-xml'
gem 'draper'
gem 'fast_jsonapi'
gem 'oj'
gem 'ox'

# Compile and serve assets
gem 'autoprefixer-rails'
gem 'csso-rails'
gem 'font-awesome-sass'
gem 'sassc-rails'
gem 'uglifier'
gem 'webpacker'

# View template compilers and helpers
gem 'jbuilder', '~> 2.5'
gem 'redcarpet'
gem 'slim-rails'
# gem 'active_link_to'
gem 'high_voltage'
gem 'meta-tags'
gem 'simple_form'

# Reporting
gem 'jwt'

# Documentation
gem 'sdoc', group: :doc
# gem 'apipie-rails', git: 'https://github.com/Apipie/apipie-rails.git', ref: 'f697ec2a887cd73c00c846eceb2ce63a050ccb20'

# Application server
gem 'foreman'
gem 'puma-rails'

# Environment variables management
gem 'figaro'

# Sexy rails console
gem 'awesome_print'
gem 'pry-rails'

# Image and AWS S3 management
gem 'asset_sync'
gem 'carrierwave'
gem 'carrierwave-imageoptimizer'
gem 'fog-aws', '< 3'
gem 'mini_magick', '>= 4.9.4'

# Monitoring
gem 'barnes'
gem 'newrelic_rpm'
gem 'rollbar'
gem 'silencer'

# Utils
gem 'icalendar'

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '~> 3.2.0'
  gem 'web-console'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'annotate', require: false
  gem 'letter_opener'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  # gem 'travis'

  # Data generator
  gem 'ffaker'

  # Model factories
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-faker', require: false
  gem 'rubocop-i18n', require: false
  gem 'rubocop-md', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'codeclimate-test-reporter'
  gem 'codecov', require: false
  gem 'database_cleaner'
  gem 'shoulda-matchers', require: false
  gem 'simplecov'
  gem 'webmock'
end

# Heroku compatibility
gem 'rails_12factor', group: :production

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# paginator
gem 'kaminari'

# tags
gem 'acts-as-taggable-on'
