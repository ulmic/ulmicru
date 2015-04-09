module TagScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :string, -> { where tag_type: :string }
    scope :members, -> { where target_type: 'Member' }
    scope :events, -> { where target_type: 'Event' }
    scope :activity_lines, -> { where target_type: 'ActivityLine' }
    scope :teams, -> { where target_type: 'Team' }
  end
end
