# frozen_string_literal: true

# Uploads (event title_image, user avatar, startup logo) go to Yandex Cloud when
# remote_storage is true. Set in production: aws_bucket, aws_access_key_id, aws_secret_access_key.
# Optional: fog_region (default ru-central1), fog_endpoint, fog_host, aws_host (CDN URL).
remote_storage =
  (Rails.env.production? || Rails.env.staging?) &&
  ENV['aws_bucket'].to_s.strip != '' &&
  ENV['aws_access_key_id'].to_s.strip != '' &&
  ENV['aws_secret_access_key'].to_s.strip != ''

if Rails.env.production? && !remote_storage
  missing = []
  missing << 'aws_bucket' if ENV['aws_bucket'].to_s.strip == ''
  missing << 'aws_access_key_id' if ENV['aws_access_key_id'].to_s.strip == ''
  missing << 'aws_secret_access_key' if ENV['aws_secret_access_key'].to_s.strip == ''
  Rails.logger.warn "[CarrierWave] Remote storage (Yandex) disabled: missing ENV #{missing.join(', ')}. Uploads will be stored locally."
end

if remote_storage
  require 'carrierwave/storage/fog'
else
  require 'carrierwave/storage/file'
end

CarrierWave.configure do |config|
  config.storage = remote_storage ? :fog : :file

  if remote_storage
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['aws_access_key_id'],
      aws_secret_access_key: ENV['aws_secret_access_key'],
      region: ENV.fetch('fog_region', 'ru-central1'),
      # Yandex Cloud Object Storage (S3-compatible)
      endpoint: ENV.fetch('fog_endpoint', 'https://storage.yandexcloud.net'),
      host: ENV.fetch('fog_host', 'storage.yandexcloud.net'),
      path_style: true,
      aws_signature_version: 4
    }
    config.fog_use_ssl_for_aws = true
    config.fog_directory    = ENV['aws_bucket']
    config.fog_public       = true
    config.fog_attributes   = { 'Cache-Control' => "max-age=#{365.days.to_i}" }
    config.asset_host       = ENV.fetch('aws_host', nil)
  end
  config.cache_dir        = "#{Rails.root}/tmp/uploads"

  config.ignore_integrity_errors = false
  config.ignore_processing_errors = false
  config.ignore_download_errors = false
end
