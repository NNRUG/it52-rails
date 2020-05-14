# frozen_string_literal: true

ruby '2.7.0'

source 'https://rubygems.org'

gem 'rails', '~> 5.2.4', '>= 5.2.4.1'

# Databases
gem 'hiredis'
gem 'pg'
gem 'redis'

# Queue
gem 'sidekiq', '>= 5.2.7'

# Integrations
gem 'http'
gem 'mailchimp-api', require: 'mailchimp'
gem 'mailgun-ruby'

# Normalization and locales
gem 'postrank-uri'
gem 'rails-i18n', '>= 5.1.3'
gem 'unicode'

# Authentication and authorization
gem 'cancancan'
gem 'devise', '>= 4.7.1'
gem 'omniauth', '>= 1.9.0'
gem 'omniauth-facebook', '>= 5.0.0'
gem 'omniauth-github', github: 'omniauth/omniauth-github'
gem 'omniauth-google-oauth2', '>= 0.8.0'
gem 'omniauth-twitter', '>= 1.4.0'
gem 'omniauth-vkontakte', '>= 1.5.1'

# Request handling
gem 'friendly_id'
gem 'has_scope', '>= 0.7.2'

# Decoration
gem 'active_model_serializers', '>= 0.10.10'
gem 'activemodel-serializers-xml'
gem 'draper', '>= 3.1.0'
gem 'fast_jsonapi'
gem 'oj'
gem 'ox'

# Compile and serve assets
gem 'autoprefixer-rails'
gem 'font-awesome-sass'
gem 'sassc-rails', '>= 2.1.2'
gem 'uglifier'
gem 'webpacker', '>= 4.2.2'

# View template compilers and helpers
gem 'jbuilder', '~> 2.5'
gem 'redcarpet'
gem 'slim-rails', '>= 3.2.0'
# gem 'active_link_to'
gem 'high_voltage'
gem 'meta-tags', '>= 2.13.0'
gem 'simple_form', '>= 5.0.2'

# Reporting
gem 'jwt'

# Documentation
gem 'sdoc', group: :doc
# gem 'apipie-rails', git: 'https://github.com/Apipie/apipie-rails.git', ref: 'f697ec2a887cd73c00c846eceb2ce63a050ccb20'

# Application server
gem 'puma-rails', '>= 0.0.2'

# Sexy rails console
gem 'awesome_print'
gem 'pry-rails'

# Image and AWS S3 management
gem 'ruby-vips', '2.0.15'

gem 'asset_sync'
gem 'carrierwave'
gem 'carrierwave-vips'
gem 'fog-aws', '< 3'

# Monitoring
gem 'barnes'
gem 'newrelic_rpm'
gem 'rollbar'
gem 'silencer'

# paginator
gem 'kaminari'

# tags
gem 'acts-as-taggable-on'

# Utils
gem 'icalendar'

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '~> 3.2.0'
  gem 'web-console', '>= 3.7.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'annotate', require: false
  gem 'capistrano', require: false
  gem 'letter_opener'
end

group :development, :test do
  gem 'bootsnap'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  # gem 'travis'

  # Data generator
  gem 'ffaker'

  # Model factories
  gem 'factory_bot_rails', '>= 5.1.1'
  gem 'rspec-rails', '>= 3.9.0'
  gem 'rubocop', require: false
  gem 'rubocop-faker', require: false
  gem 'rubocop-i18n', require: false
  gem 'rubocop-md', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', '>= 2.4.2', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'codecov', require: false
  gem 'database_cleaner', require: false
  gem 'shoulda-matchers', require: false
  gem 'simplecov', require: false
  gem 'test-prof', require: false
  gem 'webmock', require: false
end

# Heroku compatibility
gem 'rails_12factor', group: :production

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
