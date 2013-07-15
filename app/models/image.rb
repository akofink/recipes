class Image < ActiveRecord::Base
  mount_uploader :data, ImageUploader

  validates_presence_of :data

  belongs_to :recipe
  belongs_to :user
end
