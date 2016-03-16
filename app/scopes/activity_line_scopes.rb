require 'scopes_rails/state_machine/scopes'

module ActivityLineScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes

  included do
    scope :presented, -> { where.not(state: :removed).order('id ASC')}
    scope :central_programs, -> { where activity_type: :central_program }
    scope :local_projects, -> { where activity_type: :local_project }
    scope :corporative, -> { where activity_type: :corporative }
    scope :has_curators, -> { where.not(activity_type: :event_line) }
  end
end
