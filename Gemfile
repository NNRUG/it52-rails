source 'https://rubygems.org'

ruby '2.2.1'

gem 'rails', '~> 4.1.8'
gem 'rails-i18n'

# Database
gem 'pg'

# Mailing
gem 'mailchimp-api', require: 'mailchimp'

# Normaliztion
gem 'unicode'
gem 'postrank-uri'

# Authentication and authorization
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-vkontakte'
gem 'omniauth-github'
gem "omniauth-google-oauth2"
gem "omniauth-twitter"
gem 'cancancan', '~> 1.7'

# Request handling
gem 'responders'
gem 'has_scope'
gem 'friendly_id'
gem 'active_model_serializers', '~> 0.10.0.rc1'

# Decoration
gem 'draper'

# Compile and serve assets
gem 'sprockets-rails', '2.1.3'    # Locked for /assets/ prefix feature
gem 'jquery-rails'
gem 'sass-rails', '4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'styx'
gem 'compass-rails'
gem 'marked-rails'
gem 'bootstrap-sass', '3.1.1.1'
gem 'font-awesome-sass'
gem 'gon'
gem "autoprefixer-rails"
gem 'csso-rails'
gem 'heroku_rails_deflate', group: :production
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'momentjs-rails'
gem 'bootstrap3-datetimepicker-rails'

# View template compilers and helpers
gem 'jbuilder', '~> 2.0'
gem 'slim-rails'
gem 'redcarpet'
gem 'active_link_to'
gem 'high_voltage', '~> 2.1.0'
gem 'simple_form', '~> 3.1.0.rc2'

# Caching
gem 'dalli'

# Documentation
gem 'sdoc', '~> 0.4.0', group: :doc

# Application server
gem 'unicorn'

# Environment variables management
gem 'figaro'

# Sexy rails console
gem 'awesome_print'
gem 'pry-rails'

# Heroku compatibility
gem 'rails_12factor'

# Image and AWS S3 management
gem "fog-aws"
gem 'mini_magick'
gem 'carrierwave'
gem 'asset_sync'

# Monitoring
gem 'newrelic_rpm'
gem 'runtimeerror_notifier'

# Utils
gem 'icalendar'

group :development do
  gem 'annotate', require: false
  gem 'quiet_assets'
  gem 'letter_opener'
end

group :development, :test do
  # Data generator
  gem 'ffaker'

  # Model factories
  gem 'factory_girl_rails'
  gem 'shoulda-matchers', require: false
  gem "codeclimate-test-reporter", require: false
  gem 'rspec-rails', '~> 3.0'
end
