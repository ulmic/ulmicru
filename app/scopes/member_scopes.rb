module MemberScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :presented, -> { where('state != \'removed\' AND state != \'not_member\'').order('ticket ASC') }
    scope :confirmed, -> { where(state: :confirmed).order('id ASC') }
    scope :declined, -> { where(state: :declined).order('id ASC') }
    scope :removed, -> { where(state: :removed).order('id ASC') }
    scope :unviewed, -> { where(state: :unviewed, type: 'Member').order('id ASC') }
    scope :unavailable, -> { where(state: :unavailable).order('id ASC') }
  end
end
