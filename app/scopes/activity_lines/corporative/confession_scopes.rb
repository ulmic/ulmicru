require 'scopes_rails/state_machine_scopes'

module ActivityLines::Corporative::ConfessionScopes
  extend ActiveSupport::Concern
  include StateMachineScopes

  included do
    scope :debut, -> { where nomination: :debut }
    scope :number_one, -> { where nomination: :number_one }
    scope :of_the_year, -> (year) { where year: year }
  end
end
