module MemberScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :presented, -> { where('state != \'removed\' AND state != \'not_member\'') }
    scope :confirmed, -> { where state: :confirmed }
    scope :declined, -> { where state: :declined }
    scope :removed, -> { where state: :removed }
    scope :unviewed, -> { where state: :unviewed }
  end
end
