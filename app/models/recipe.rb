class Recipe < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  has_many :images, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :images, allow_destroy: true

  self.per_page = 12

  scope :with_keyword, ->(kw='') do
    kw = "%#{kw}%"
    where(
      "title ilike ? OR body ilike ?",
      kw,
      kw
    )
  end

  def has_images?
    images.present?
  end

  def random_image
    @random_image ||= valid_images.sample || Image.blank
  end

  def valid_images
    images.reject(&:valid?).map(&:destroy)
    images
  end

  def random_thumbnail_url
    random_image.thumb.url
  end

  def thumb_title
    if title.length > 20
      "#{title[0..20]}".try :html_safe
    else
      title
    end
  end
end
