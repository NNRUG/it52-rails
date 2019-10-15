# frozen_string_literal: true

require 'barnes'

workers Integer(ENV.fetch('WEB_CONCURRENCY') { 1 })
threads_count = Integer(ENV.fetch('RAILS_MAX_THREADS') { 4 })
threads 2, threads_count

preload_app!

rackup      DefaultRackup
port        Integer(ENV.fetch('PORT') { 3000 })
environment ENV.fetch('RACK_ENV') { 'development' }

stdout_redirect '/dev/stdout', '/dev/stderr', true

before_fork do
  # worker specific setup

  Barnes.start # Must have enabled worker mode for this to block to be called
end

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end
