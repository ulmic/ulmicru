module DocumentScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :presented, -> { where.not(state: :removed).order('id ASC') }
    scope :removed, -> { where state: :removed }
  end
end
