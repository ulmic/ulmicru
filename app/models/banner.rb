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

  include StateMachine::Scopes
  scope :active, -> { where(state: :active).order('created_at ASC') }
  scope :presented, -> { where.not(state: :removed).order('id ASC') }
  scope :with_vertical, -> { where.not(vertical: nil) }
  scope :with_horizontal, -> { where.not(horizontal: nil) }
  scope :actual, -> { where('begin_date < ? AND end_date > ?', DateTime.now, DateTime.now) }
  scope :need_to_review, -> { where 'state = \'unviewed\' OR state = \'updated\'' }
  include DurationManagment

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

  def self.collections
    [ :actual, :active, :unviewed, :removed ]
  end
end
