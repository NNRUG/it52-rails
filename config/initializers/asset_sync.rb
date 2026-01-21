# frozen_string_literal: true

AssetSync.configure do |config|
  enabled =
    (Rails.env.production? || Rails.env.staging?) &&
    ENV['aws_bucket'].to_s.strip != '' &&
    ENV['aws_access_key_id'].to_s.strip != '' &&
    ENV['aws_secret_access_key'].to_s.strip != ''

  config.enabled = enabled if config.respond_to?(:enabled=)

  # When not fully configured, do nothing (prevents build-time crashes during assets:precompile)
  next unless enabled

  config.fog_provider = 'AWS'
  config.aws_access_key_id = ENV['aws_access_key_id']
  config.aws_secret_access_key = ENV['aws_secret_access_key']
  # To use AWS reduced redundancy storage.
  # config.aws_reduced_redundancy = true
  config.fog_directory = ENV['aws_bucket']

  # Invalidate a file on a cdn after uploading files
  # config.cdn_distribution_id = "12345"
  # config.invalidate = ['file1.js']

  # Increase upload performance by configuring your region
  config.fog_region = ENV.fetch('fog_region', 'ru-central1')
  # Yandex Cloud Object Storage (S3-compatible) endpoint + path-style addressing
  config.fog_path_style = true
  config.fog_options = {
    endpoint: ENV.fetch('fog_endpoint', 'https://storage.yandexcloud.net'),
    host: ENV.fetch('fog_host', 'storage.yandexcloud.net'),
    aws_signature_version: 4
  }
  #
  # Don't delete files from the store
  # config.existing_remote_files = "keep"
  #
  # Automatically replace files with their equivalent gzip compressed version
  config.gzip_compression = true
  #
  # Use the Rails generated 'manifest.yml' file to produce the list of files to
  # upload instead of searching the assets directory.
  # config.manifest = true
  #
  # Fail silently.  Useful for environments such as Heroku
  # config.fail_silently = true

  config.add_local_file_paths do
    # Any code that returns paths of local asset files to be uploaded
    # Like Webpacker
    public_root = Rails.root.join('public')
    Dir.chdir(public_root) do
      packs_dir = Webpacker.config.public_output_path.relative_path_from(public_root)
      Dir[File.join(packs_dir, '/**/**')]
    end
  end
end
