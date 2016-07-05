class Comment < ApplicationRecord
  belongs_to :recipe
  belongs_to :user

  def self.chronological
    order :created_at
  end
end
