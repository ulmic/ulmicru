module TeamScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :active, -> { where state: :active }
  end
end
