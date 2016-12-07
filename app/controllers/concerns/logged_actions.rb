module Concerns
  module LoggedActions
    include ::ModelsConcern
    include ParamsComparingConcern
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

    def save_object
      @prev_object_attributes = object_attributes_with_associations model_class.find(params[:id]), params[to_param(model_class.name)]
    end

    def log_action
      if self.status == 302 && !not_logged_controllers.include?(self.class)
        LoggedAction.create! user_id: current_user.id,
          record_type: model_class.name,
          record_id: params[:id] || model_class.last.id,
          action_type: action_name,
          params: transform_to_save(log_params&.except(*not_logged_attributes))
      end
    end
  end
end
