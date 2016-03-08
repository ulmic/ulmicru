require 'scopes_rails/state_machine_scopes'

module TagScopes
  extend ActiveSupport::Concern
  include StateMachineScopes

  included do
    scope :string, -> { where tag_type: :string }
    scope :members, -> { where target_type: 'Member' }
    scope :events, -> { where target_type: 'Event' }
    scope :activity_lines, -> { where target_type: 'ActivityLine' }
    scope :teams, -> { where target_type: 'Team' }
    scope :news, -> { where record_type: 'News' }
    scope :articles, -> { where record_type: 'Article' }
  end
end
