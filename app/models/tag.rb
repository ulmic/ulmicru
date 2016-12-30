class Tag < ActiveRecord::Base
  belongs_to :record, polymorphic: true
  belongs_to :target, polymorphic: true

  validates :record_id, presence: true
  validates :record_type, presence: true
  validates :tag_type, presence: true
  validates :target_id, uniqueness: { scope: [ :target_type, :record_id, :record_type, :state ] },
                        allow_nil: true
  validates :text, uniqueness: { scope: [ :record_id, :record_type ] },
                   unless: Proc.new { |t| t.text.blank? }

  extend Enumerize
  enumerize :record_type, in: [ 'Article', 'News' ]
  enumerize :target_type, in: [ 'ActivityLine', 'Event', 'Member', 'Team' ]
  enumerize :tag_type, in: [ :string, :link ]

  state_machine :state, initial: :active do
    state :active
    state :removed

    event :activate do
      transition removed: :active
    end

    event :restore do
      transition removed: :active
    end

    event :remove do
      transition active: :removed
    end
  end

  include PgSearch
  pg_search_scope :search_everywhere, against: [ :text, :target_id, :record_id ]
end
