class Recipe < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true

  has_many :images, dependent: :destroy
  has_one :user
  accepts_nested_attributes_for :images, allow_destroy: true
end
