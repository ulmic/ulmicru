class Project < ActiveRecord::Base
  extend Enumerize
  enumerize :project_type, in: [ :default, :it_way ], default: :default

  state_machine :state, initial: :active do
    state :active
    state :removed

    event :remove do
      transition all => :removed
    end

    event :restore do
      transition all => :active
    end
  end

  include StateMachine::Scopes
  include PgSearch
  pg_search_scope :search_everywhere, against: [ :title ]

  def self.collections
    [:active, :removed]
  end
end
