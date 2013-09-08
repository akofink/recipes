class Comment < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :user

  scope :chronological, -> { order :updated_at }
end
