module MemberScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :presented, -> { where('state != \'removed\' AND state != \'not_member\'').order('ticket ASC') }
    scope :confirmed, -> { where(state: :confirmed).order('ticket DESC') }
    scope :declined, -> { where(state: :declined).order('ticket DESC') }
    scope :removed, -> { where(state: :removed).order('ticket DESC') }
    scope :unviewed, -> { where(state: :unviewed, type: 'Member').order('id ASC') }
    scope :unavailable, -> { where(state: :unavailable).order('ticket ASC') }
  end
end
