# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  process :resize_to_limit => [500, 500]

  storage Rails.env.production? ? :fog : :file

  version :thumb do
    process :resize_to_fill => [200,200]
  end

  def store_dir
    if Rails.env.production?
      "uploads/images/#{model.class.to_s.pluralize.downcase}/#{model.recipe_id}"
    else
      "images/#{model.class.to_s.pluralize.downcase}/#{model.recipe_id}"
    end
  end

  def extension_white_list
    %w(jpg jpeg gif png tiff bmp svg)
  end
end
