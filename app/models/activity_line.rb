class ActivityLine < ActiveRecord::Base
  extend Enumerize

  belongs_to :member
  has_many :events
  has_many :tags, as: :target, dependent: :destroy

  mount_uploader :logo, PhotoUploader

  enumerize :activity_type, in: [ :central_program, :local_project, :corporative, :event_line ]
  enumerize :organization_type, in: [ :ulmic, :not_ulmic ]

  state_machine :state, initial: :active do
    state :unviewed
    state :active
    state :removed
    state :closed

    event :remove do
      transition all => :removed
    end

    event :restore do
      transition removed: :unviewed
    end

    event :close do
      transition active: :closed
    end
  end

  include TagsHelper
  include PgSearch
  pg_search_scope :search_everywhere, against: [:title]
end
