require 'scopes_rails/state_machine_scopes'

module VoteScopes
  extend ActiveSupport::Concern

  included do
    scope :likes, -> { where difference: 1 }
    scope :dislikes, -> { where difference: -1 }
  end
end
