require 'scopes_rails/state_machine_scopes'

module CommentScopes
  extend ActiveSupport::Concern
  include StateMachineScopes

  included do
    scope :presented, -> { where.not(state: :removed).order('id DESC') }
    scope :published, -> { where.not(state: :removed).order('created_at ASC') }
  end
end
