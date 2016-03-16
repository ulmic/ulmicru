require 'scopes_rails/state_machine/scopes'

module Delivery::CampaignScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes
end
