module TeamScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :active, -> { where state: :active }
    scope :removed, -> { where state: :removed }
  end
end
