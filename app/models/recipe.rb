class Recipe < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true

  has_many :images, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :images, allow_destroy: true

  self.per_page = 12

  scope :filter, ->(filter='') do
    filter = "%#{filter}%"
    where(
      "title ilike ? OR body ilike ?",
      filter,
      filter
    )
  end

  def has_images?
    images.present?
  end

  def random_image
    images.sample || google_image
  end

  def random_thumbnail_url
    (
      random_image.try(:thumb).try(:url)
    ).to_s
  end

  def google_image
    unless images.any? || Rails.env.test?
      image = Image.new
      remote_url = Google::Search::Image.new(
        query: "#{title} recipe",
        image_type: :photo,
        image_size: :large,
      ).try(:first).try(:uri)
      image.remote_data_url = remote_url
      image.recipe = self
      images.first
    end
  end
end
