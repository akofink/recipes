class Recipe < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true

  has_many :images, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :images, allow_destroy: true
end
