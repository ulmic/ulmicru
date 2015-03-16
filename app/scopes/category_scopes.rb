module CategoryScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :roots, -> { where parent_id: nil }
    scope :last_childs, -> { where is_last: true }
  end
end
