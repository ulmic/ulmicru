module CategoryScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :roots, -> { presented.where(parent_id: nil)}
    scope :last_childs, -> { where is_last: true }
    scope :presented, -> { where.not state: :removed}
  end
end
