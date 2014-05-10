# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  process :resize_to_limit => [500, 500]

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    if Rails.env.production?
      if model.recipe_id
        "uploads/images/recipes/#{model.recipe_id}"
      else
        "uploads/images/#{model.id}"
      end
    else
      if model.recipe_id
        "images/recipes/#{model.recipe_id}"
      else
        "images/#{model.id}"
      end
    end
  end

  def extension_white_list
    %w(jpg jpeg gif png tiff bmp svg)
  end
end
