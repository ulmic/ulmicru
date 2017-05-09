require "#{Rails.root}/lib/state_machine/list"

module StateMachine::Scopes
  extend ActiveSupport::Concern

  included do
    StateMachine::List.states_list(model_name.name.constantize).each do |scope_name, query|
      scope scope_name, query
    end
  end
end
