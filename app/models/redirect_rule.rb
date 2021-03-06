class RedirectRule < ActiveRecord::Base
  validates :old_path, presence: true,
		  uniqueness: { scope: :state }
  validates :redirect_to, presence: true

  extend Enumerize
  enumerize :status, in: [ :moved_temporarily, :moved_permanently ]

  state_machine :state, initial: :active do
    state :active
    state :removed

    event :remove do
      transition active: :removed
    end

    event :restore do
      transition removed: :active
    end
  end

  include StateMachine::Scopes

  include PgSearch
  pg_search_scope :search_everywhere, against: [ :old_path, :redirect_to, :status, :reason ]

  def self.collections
    [ :active ]
  end
end
