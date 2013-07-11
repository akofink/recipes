class Image < ActiveRecord::Base
  mount_uploader :data, ImageUploader

  belongs_to :recipe
end
