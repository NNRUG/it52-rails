# frozen_string_literal: true

# require 'carrierwave/storage/abstract'
if remote_storage = (Rails.env.production? || Rails.env.staging?)
  require 'carrierwave/storage/fog'
else
  require 'carrierwave/storage/file'
end

CarrierWave.configure do |config|
  config.storage = remote_storage ? :fog : :file

  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV.fetch('aws_access_key_id') { 'aws_access_key_id' },
    aws_secret_access_key: ENV.fetch('aws_secret_access_key') { 'aws_secret_access_key' },
    region: ENV.fetch('fog_region') { 'fog_region' },
    host: ENV.fetch('fog_host') { 'fog_host' }
  }
  config.fog_use_ssl_for_aws = true
  config.fog_directory    = ENV.fetch('aws_bucket') { 'aws_bucket' }
  config.fog_public       = true
  config.fog_attributes   = { 'Cache-Control' => "max-age=#{365.days.to_i}" }
  config.asset_host       = ENV.fetch('aws_host') { nil }
  config.cache_dir        = "#{Rails.root}/tmp/uploads"

  config.ignore_integrity_errors = false
  config.ignore_processing_errors = false
  config.ignore_download_errors = false
end
