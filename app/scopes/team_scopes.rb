module TeamScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :active, -> { where state: :active }
    scope :unviewed, -> { where state: :unviewed }
    scope :removed, -> { where state: :removed }
    scope :visible, -> { where publicity: :visible }
    scope :hidden, -> { where publicity: :hidden }
  end
end
