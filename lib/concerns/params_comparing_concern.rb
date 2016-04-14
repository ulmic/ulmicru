module Concerns
  module ParamsComparingConcern
    def log_params
      case action_name
      when 'update'
        object = model_class.find(params[:id])
        attributes_diff(object.attributes, params[to_param(model_class.name)], @prev_object.attributes)
      when 'create'
        params[to_param(model_class.name)]
      when 'destroy'
	@prev_object.attributes
      end
    end

    def attributes_diff(object_hash, params, prev_object_hash)
      unless comparing(object_hash, params) == {}
	comparing object_hash, prev_object_hash
      end
    end

    def comparing(hash1, hash2)
      comparison = {}
      hash1.except('updated_at').each do |key, value|
	next unless hash2[key].present?
	comparison[key] = value unless hash2[key] == value
      end
      comparison
    end

    def to_param(model_class_name)
      model_class_name.underscore.gsub '/', '_'
    end
  end
end
