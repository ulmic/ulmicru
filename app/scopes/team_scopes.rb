module TeamScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :visible, -> { where publicity: :visible }
    scope :hidden, -> { where publicity: :hidden }
  end
end
