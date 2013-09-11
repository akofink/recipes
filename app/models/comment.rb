class Comment < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :user

  def self.chronological
    order :updated_at
  end
end
