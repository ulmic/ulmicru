module TeamScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :visible, -> { where publicity: :visible }
    scope :hidden, -> { where publicity: :hidden }
    scope :presented, -> { where.not(state: :removed) }
  end
end
