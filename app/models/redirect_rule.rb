class RedirectRule < ActiveRecord::Base
  validates :url, presence: true,
		  url: true
  validates :redirect_to, presence: true,
			  url: true

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

  include PgSearch
  pg_search_scope :search_everywhere, against: [ :url, :redirect_to, :status, :reason ]
end
