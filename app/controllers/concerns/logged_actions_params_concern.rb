module Concerns
  module LoggedActionsParamsConcern
    def nested_params_contains?(logged_action, association, **attributes)
      logged_action.parsed_params["#{association}_attributes"]&.values&.map do |hash|
        (attributes.to_a - hash.to_a).empty?
      end&.include? true
    end

    def added_nested_attribute?(param, association_name)
      param.first == '+' && param[1].split('.')[0] == association_name.to_s
    end

    def added_nested_attribute_id(param)
      param[1].split('.')[1].to_i
    end
  end
end
