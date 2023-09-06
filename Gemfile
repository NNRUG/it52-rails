# frozen_string_literal: true

ruby '3.1.1'

source 'https://rubygems.org'

gem 'rails', '~> 6.1'
gem 'rails-i18n', '~> 6.0'

# Databases
gem 'hiredis'
gem 'pg'
gem 'redis'

# Queue
gem 'sidekiq', '>= 5.2.7'

# Integrations
gem 'http'
gem 'net-smtp'
gem 'net-pop'
gem 'net-imap'
gem 'multipart-post'
gem 'mailchimp-api', require: 'mailchimp'
gem 'mailgun-ruby'

# Normalization and locales
gem 'postrank-uri'
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
gem 'friendly_id', '>= 5.3.0'
gem 'has_scope', '>= 0.7.2'

# Decoration
gem 'active_model_serializers', '>= 0.10.10'
gem 'activemodel-serializers-xml', '>= 1.0.2'
gem 'draper', '>= 3.1.0'
gem 'fast_jsonapi', '>= 1.5'
gem 'oj'
gem 'ox'

# Compile and serve assets
gem 'autoprefixer-rails'
gem 'font-awesome-sass'
gem 'sassc-rails', '>= 2.1.2'
gem 'uglifier'
gem 'webpacker'

# View template compilers and helpers
gem 'jbuilder', '~> 2.9', '>= 2.9.1'
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
gem 'ruby-vips'

gem 'asset_sync', '>= 2.9.0'
gem 'carrierwave', '>= 2.0.2'
gem 'carrierwave-vips', '>= 1.2.0'
gem 'fog-aws', '< 3'

# Monitoring
gem 'newrelic_rpm'
gem 'rollbar'
gem 'silencer'

# paginator
gem 'kaminari', '>= 1.2.1'

# tags
gem 'acts-as-taggable-on', '>= 6.5.0'

# Utils
gem 'icalendar'

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen'
  gem 'web-console', '>= 4.2.1'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'annotate', '>= 3.0.3', require: false
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
  gem 'shoulda-matchers', '>= 4.2.0', require: false
  gem 'simplecov', require: false
  gem 'test-prof', require: false
  gem 'webmock', require: false
end

# Heroku compatibility
gem 'rails_12factor', group: :production

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
