# frozen_string_literal: true

namespace :db do
  desc 'Sync database environment –> development'
  task :sync do
    on roles(:db) do
      env = fetch(:stage).to_s
      yaml = load_yaml
      db_remote = yaml[env]
      db_local = yaml[local_environment]
      timestamp = Time.zone.now.strftime('%F-%H%M%S')
      filename = "/tmp/it52-postgresql.#{env}.#{timestamp}.sql.dump"
      execute "#{build_pg_command_string('pg_dump', db_remote)} -Fc -Z9 > #{filename}"
      download! filename, filename
      system("#{build_pg_command_string('pg_restore', db_local)} --verbose --clean --no-acl --no-owner #{filename}")
    end
  end

  desc 'Download part of remote database and seed it in development'
  task :seed do
    on roles(:db) do
      info 'Building partial dump. Please wait…'
      output = capture(:sudo, :docker, :exec, :it52_rails_1, :bundle, :exec, :rake, 'db:dump')
      info 'Partial dump completed.'
      filename = output.lines.last
      info 'Copying dump…'
      execute(:sudo, :docker, :cp, "it52_rails_1:#{filename}", filename)
      download! filename, filename
      system("#{build_pg_command_string('psql', load_yaml[local_environment])} -f #{filename}")
      info 'Done!'
    end
  end
end

def local_environment
  ENV.fetch('RAILS_ENV') { 'development' }
end

def load_yaml
  YAML.safe_load(ERB.new(File.read(File.expand_path('../../../config/database.yml', __dir__))).result)
end

def build_pg_command_string(command, database)
  arr = %w[sudo docker exec it52_rails_1]
  arr << "-e PGPASSWORD=#{database['password']}" if database['password']
  arr << command
  arr << '${DATABASE_URL}'
  arr.join(' ')
end
