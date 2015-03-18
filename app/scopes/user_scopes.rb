module UserScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :admins, -> { where role: :admin }
    scope :presented, -> { where.not(state: :removed) }
    scope :removed, -> { where state: :removed }
    scope :unviewed, -> { where state: :unviewed }
  end
end
