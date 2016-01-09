class Banner < ActiveRecord::Base
  mount_uploader :vertical, PhotoUploader
  mount_uploader :horizontal, PhotoUploader

  validates :link, url: true
  validate :begin_before_end_date
  validate :check_dimensions
  validate :one_of_images_presents

  state_machine :state, initial: :active do
    state :active
    state :unviewed
    state :removed

    event :make_active do
      transition unviewed: :active
    end
    event :hide do
      transition active: :unviewed
    end
    event :remove do
      transition all => :removed
    end
    event :restore do
      transition removed: :unviewed
    end
  end

  include BannerScopes
  include Concerns::DurationManagment

  include PgSearch
  pg_search_scope :search_everywhere, against: [:link]

  private

  def check_dimensions
    if vertical.width
      errors.add :vertical, I18n.t('.is_not_vertical') unless vertical.width < vertical.height
    end
    if horizontal.width
      errors.add :horizontal, I18n.t('.is_not_horizontal') unless horizontal.width >= horizontal.height
    end
  end

  def one_of_images_presents
    errors.add :images, I18n.t('.must_be_present') unless horizontal.present? || vertical.present?
  end
end
