class Banner < ActiveRecord::Base
  mount_uploader :vertical, PhotoUploader
  mount_uploader :horizontal, PhotoUploader

  validates :link, url: true
  validate :begin_before_end_date
  validate :check_dimensions
  validate :one_of_images_presents

  include BannerScopes
  include Concerns::DurationManagment

  state_machine :state, initial: :showed do
    state :active
    state :unviewed
    state :removed

    event :show do
      transition unviewed: :showed
    end
    event :hide do
      transition showed: :unviewed
    end
    event :remove do
      transition all => :removed
    end
    event :restore do
      transition removed: :unviewed
    end
  end

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
    errors.add :images, I18n.t('.must_be_present') if horizontal.width.nil? && vertical.width.nil?
  end
end
