# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  process :crop

  def crop width = 500, height = 500
    #manipulate! do |image|
      #image.resize_to_fill width, height
    #end
  end

  def store_dir
    if model.recipe_id
      "uploads/images/recipes/#{model.recipe_id}"
    else
      "uploads/images/#{model.id}"
    end
  end

  def extension_white_list
    %w(jpg jpeg gif png tiff bmp svg)
  end
end
