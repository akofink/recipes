# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  process :resize_to_fill => [500, 500]

  storage :fog if Rails.env.production?

  version :thumb do
    process :resize_to_fill => [200,200]
  end

  def store_dir
    "uploads/images/recipes/#{model.recipe_id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png tiff bmp svg)
  end
end
