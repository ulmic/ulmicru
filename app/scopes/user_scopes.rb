require 'scopes_rails/state_machine/scopes'

module UserScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes

  included do
    scope :admins, -> { where role: :admin }
    scope :presented, -> { where.not(state: :removed).order('id DESC') }
    scope :unviewed, -> { where(state: :unviewed, type: nil).where.not(email: nil).order('id DESC') }
    scope :subscribed_to_deliveries, -> { joins(:subscriptions).where 'subscriptions.subscription_type = ?', :deliveries }
    scope :with_email, -> { where.not email: nil }
    scope :without_current_positions, -> {
      where.not(id: Position.current_positions.map(&:member_id).uniq)
    }
    scope :need_to_review, -> { where 'state = \'unviewed\' OR state = \'updated\'' }
    scope :just_users, -> { where type: nil }
    scope :just_members, -> { where type: 'Member' }
    scope :just_questionaries, -> { where type: 'Questionary' }
    scope :tech_admins, -> { where role: :tech_admin }
  end
end
