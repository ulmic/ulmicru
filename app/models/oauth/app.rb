class Oauth::App < ActiveRecord::Base
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
