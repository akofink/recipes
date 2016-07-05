class Recipe < ApplicationRecord
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
    @random_image ||= valid_images.sample || google_image
  end

  def valid_images
    images.reject(&:valid?).map(&:destroy)
    images
  end

  def random_thumbnail_url
    random_image.thumb.url
  end

  def google_image
    image = Image.new

    unless Rails.env.test?
      image.remote_data_url = Google::Search::Image.new(
        query: "#{title} recipe",
        image_type: :photo,
        image_size: :large,
      ).try(:to_a).try(:sample).try(:uri)
      image.recipe = self
      image.save
    end

    image
  end

  def thumb_title
    if title.length > 20
      "#{title[0..20]}".try :html_safe
    else
      title
    end
  end
end
