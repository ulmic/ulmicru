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
  enumerize :target_type, in: [ 'Member', 'Event', 'ActivityLine', 'Team' ]
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

  include StateMachine::Scopes

  scope :string, -> { where tag_type: :string }
  scope :members, -> { where target_type: 'Member' }
  scope :events, -> { where target_type: 'Event' }
  scope :activity_lines, -> { where target_type: 'ActivityLine' }
  scope :teams, -> { where target_type: 'Team' }
  scope :news, -> { where record_type: 'News' }
  scope :articles, -> { where record_type: 'Article' }
  scope :empty, -> { active.where tag_type: :link, target_id: nil }
  include PgSearch
  pg_search_scope :search_everywhere, against: [ :text, :target_id, :record_id ]
end
