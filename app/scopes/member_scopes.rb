module MemberScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :presented, -> { where('state != \'removed\' AND state != \'not_member\'').order('ticket ASC') }
    scope :confirmed, -> { where(state: :confirmed).order('id ASC') }
    scope :declined, -> { where state: :declined }
    scope :removed, -> { where state: :removed }
    scope :unviewed, -> { where state: :unviewed }
    scope :unavailable, -> { where state: :unavailable }
  end
end
