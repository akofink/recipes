class Recipe < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true

  has_many :images, dependent: :destroy
end
