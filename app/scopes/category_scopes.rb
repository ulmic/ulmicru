module CategoryScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :roots, -> { where parent_id: nil }
  end
end
