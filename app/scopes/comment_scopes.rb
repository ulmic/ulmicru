require 'scopes_rails/state_machine/scopes'

module CommentScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes

  included do
    scope :presented, -> { where.not(state: :removed).order('id DESC') }
    scope :published, -> { where.not(state: :removed).order('created_at ASC') }
    scope :need_to_review, -> { where 'state = \'unviewed\' OR state = \'updated\'' }
  end
end
