module Event::RegistrationScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :attenders, -> { where role: :participant }
    scope :organizers, -> { where role: :organizer }
  end
end
