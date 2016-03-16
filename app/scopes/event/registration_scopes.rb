require 'scopes_rails/state_machine/scopes'

module Event::RegistrationScopes
  extend ActiveSupport::Concern

  included do
    scope :attenders, -> { where role: :participant }
    scope :organizers, -> { where role: :organizer }
    scope :date_order, -> { order 'created_at DESC' }
  end
end
