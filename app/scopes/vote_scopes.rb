require 'scopes_rails/state_machine/scopes'

module VoteScopes
  extend ActiveSupport::Concern

  included do
    scope :likes, -> { where difference: 1 }
    scope :dislikes, -> { where difference: -1 }
    scope :from_members, -> { where user_id: Member.just_members.map(&:id) }
    scope :from_users, -> { where user_id: User.just_users.map(&:id)  }
  end
end
