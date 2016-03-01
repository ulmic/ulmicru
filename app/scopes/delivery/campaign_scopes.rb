require 'scopes_rails/state_machine_scopes'

module Delivery::CampaignScopes
  extend ActiveSupport::Concern
  include StateMachineScopes
end
