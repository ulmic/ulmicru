module StateMachine::List
  def self.states_list(model_class)
    list = {}
    if model_class.methods.include? :state_machines
      model_class.state_machines.each do |name, sm|
        sm.states.each do |s|
          state_name = sm.namespace.present? ? :"#{sm.namespace}_#{s.name}" : s.name
          list[state_name] = -> { model_class.where(name => s.name) }
        end
      end
    end
    list
  end
end
