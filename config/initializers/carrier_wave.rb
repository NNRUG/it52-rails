# require 'carrierwave/storage/abstract'
# require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_provider = 'fog/aws'
  config.fog_credentials  = {
    provider:               'AWS',
    aws_access_key_id:      ENV['aws_access_key_id'],
    aws_secret_access_key:  ENV['aws_secret_access_key'],
    region:                 ENV['fog_region'],
    host:                   ENV['fog_host']
  }
  config.fog_use_ssl_for_aws = true
  config.fog_directory    = ENV['aws_bucket']
  config.fog_public       = true
  config.fog_attributes   = { 'Cache-Control' => "max-age=#{365.days.to_i}" }
  config.asset_host       = ENV['aws_host']
  config.cache_dir        = "#{Rails.root}/tmp/uploads"

  config.ignore_integrity_errors = false
  config.ignore_processing_errors = false
  config.ignore_download_errors = false
end
