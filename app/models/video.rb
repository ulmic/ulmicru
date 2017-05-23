class Video < ActiveRecord::Base
  has_many :logged_actions, as: :record
  has_many :tags, as: :record, dependent: :destroy

  validates :title, presence: true
  validates :link, presence: true

  state_machine :state, initial: :active do
    state :active
    state :removed

    event :remove do
      transition all => :removed
    end

    event :restore do
      transition removed: :active
    end
  end

  include StateMachine::Scopes
  include PgSearch
  pg_search_scope :search_everywhere, against: [ :link, :title ]
end
