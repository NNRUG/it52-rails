ruby '2.5.1'

source 'https://rubygems.org'

gem 'rails', '~> 5.2.0'
gem 'bootsnap'
# gem 'rails-i18n'

# Database
gem 'pg'

# Mailing
gem 'mailchimp-api', require: 'mailchimp'
gem 'mailgun_rails'

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
gem 'cancancan'

# Request handling
# gem 'responders'
gem 'has_scope'
gem 'friendly_id'

# Decoration
gem 'active_model_serializers'
gem 'activemodel-serializers-xml'
gem 'draper'

# Compile and serve assets
gem 'sassc-rails'
gem 'babel-transpiler'
gem 'jquery-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
# gem 'styx'
# gem 'marked-rails'
gem 'bootstrap-sass'
gem 'font-awesome-sass'
gem 'gon'
gem "autoprefixer-rails"
gem 'csso-rails'
gem 'turbolinks', '~> 5'
gem 'jquery-turbolinks'
gem 'momentjs-rails'
gem 'bootstrap3-datetimepicker-rails'

# View template compilers and helpers
gem 'jbuilder', '~> 2.5'
gem 'slim-rails'
gem 'redcarpet'
# gem 'active_link_to'
gem 'high_voltage'
gem 'simple_form'
gem 'meta-tags'

# Caching
gem 'dalli'

# Documentation
gem 'sdoc', '~> 0.4.0', group: :doc
# gem 'apipie-rails', git: 'https://github.com/Apipie/apipie-rails.git', ref: 'f697ec2a887cd73c00c846eceb2ce63a050ccb20'

# Application server
gem 'unicorn-rails'

# Environment variables management
gem 'figaro'

# Sexy rails console
gem 'awesome_print'
gem 'pry-rails'

# Image and AWS S3 management
gem 'fog-aws', '< 3'
gem 'mini_magick'
gem 'carrierwave'
gem 'asset_sync'

# Monitoring
gem 'newrelic_rpm'
gem 'runtimeerror_notifier'

# Utils
gem 'icalendar'

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'annotate', require: false
  gem 'letter_opener'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

  # Data generator
  gem 'ffaker'

  # Model factories
  gem 'factory_bot_rails'
  gem 'rspec-rails'
end

group :test do
  gem 'shoulda-matchers', require: false
  gem "codeclimate-test-reporter", require: false
end

# Heroku compatibility
gem 'rails_12factor', group: :production

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

#paginator
gem 'kaminari'
