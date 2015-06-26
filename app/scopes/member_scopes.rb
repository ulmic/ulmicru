module MemberScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :presented, -> { where('member_state != \'removed\' AND member_state != \'not_member\'').order('ticket ASC') }
    scope :confirmed, -> { where(member_state: :confirmed).not(ticket: nil).order('ticket DESC') }
    scope :declined, -> { where(member_state: :declined).order('ticket DESC') }
    scope :removed, -> { where(member_state: :removed).order('ticket DESC') }
    scope :unviewed, -> { where(member_state: :unviewed, type: 'Member').order('id ASC') }
    scope :unavailable, -> { where(state: :unavailable).order('ticket ASC') }
  end
end
