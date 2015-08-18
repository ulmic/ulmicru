module ActivityLineScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :removed, -> { where state: :removed }
    scope :active, -> { where state: :active }
    scope :unviewed, -> { where state: :unviewed }
    scope :presented, -> { where.not(state: :removed).order('id ASC')}
    scope :central_programs, -> { where activity_type: :central_program }
    scope :local_projects, -> { where activity_type: :local_project }
    scope :corporative, -> { where activity_type: :corporative }
    scope :has_curators, -> { where.not(activity_type: :event_line) }
  end
end
