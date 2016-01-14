class ActivityLine < ActiveRecord::Base
  extend Enumerize

  belongs_to :member
  has_many :events
  has_many :tags, as: :target, dependent: :destroy

  mount_uploader :logo, PhotoUploader

  enumerize :activity_type, in: [ :central_program, :local_project, :corporative, :event_line ]

  state_machine :state, initial: :active do
    state :unviewed
    state :active
    state :removed

    event :remove do
      transition all => :removed
    end

    event :restore do
      transition removed: :unviewed
    end
  end

  include ActivityLineScopes
  include PgSearch
  pg_search_scope :search_everywhere, against: [:title]
end
