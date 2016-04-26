module Concerns
  module LoggedActionsParamsConcern
    def nested_params_contains?(logged_action, association, **attributes)
      logged_action.parsed_params["#{association}_attributes"]&.values&.map do |hash|
        (attributes.to_a - hash.to_a).empty?
      end&.include? true
    end
  end
end
