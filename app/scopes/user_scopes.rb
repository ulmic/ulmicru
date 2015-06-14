module UserScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :admins, -> { where role: :admin }
    scope :presented, -> { where.not(state: :removed).order('id DESC') }
    scope :removed, -> { where(state: :removed).order('id DESC') }
    scope :unviewed, -> { where(state: :unviewed).order('id DESC') }
    scope :confirmed, -> { where(state: :confirmed).order('id DESC') }
    scope :declined, -> { where(state: :declined).order('id DESC') }
  end
end
