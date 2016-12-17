class Oauth::App < ActiveRecord::Base
  validates :client_id, uniqueness: true
  validates :url, uniqueness: true

  state_machine :state, initial: :unviewed do
    state :active
    state :removed
    state :unviewed

    event :remove do
      transition all => :removed
    end
  end

  include PgSearch
  pg_search_scope :search_everywhere, against: [:title, :url, :client_id, :client_secret]
end
