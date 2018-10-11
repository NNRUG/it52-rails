# encoding: utf-8

class UserAvatarUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  include UploaderConcern

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    ActionController::Base.helpers.asset_path("avatars_fallback/" + [version_name, "default.png"].compact.join('_'))
  end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  version :square_25 do
    process resize_to_fill: [25,25]
  end

  version :square_50 do
    process resize_to_fill: [50, 50]
  end

  version :square_150 do
    process resize_to_fill: [150, 150]
  end
end
