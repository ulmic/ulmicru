require 'scopes_rails/state_machine/scopes'

module ProtocolScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes

  included do
    scope :not_filled, -> { (where(document_id: nil) + where(scan: nil)).uniq }
  end
end
