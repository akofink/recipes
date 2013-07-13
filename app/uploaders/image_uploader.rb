# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

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
