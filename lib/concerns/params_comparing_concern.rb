module Concerns
  module ParamsComparingConcern
    def log_params
      case action_name
      when 'update'
        object = model_class.find(params[:id])
        new_params = params[to_param(model_class.name)]
        attributes = object_attributes_with_associations object, new_params
        attributes_diff attributes.except(*not_logged_attributes), new_params, @prev_object.attributes
      when 'create'
        params[to_param(model_class.name)]
      end
    end

    def attributes_diff(object_hash, params, prev_object_hash)
      if comparing(object_hash, params) == {}
        comparing object_hash, prev_object_hash
      end
    end

    def object_attributes_with_associations(object, params)
      attributes = object.attributes
      params.keys.each do |key|
        if key.to_s.include? 'attributes'
          attributes.merge!(object.send(key.split('_')[0]).reduce({}) do |a_hash, ass|
            a_hash.merge! ass.id => ass.attributes
          end)
        end
      end
      attributes
    end

    def comparing(hash1, hash2)
      comparison = {}
      hash1.except('updated_at').each do |key, value|
        next unless hash2[key].present?
        if value.is_a? ActiveSupport::TimeWithZone
          if hash2[key].to_datetime.to_s.include? "+00"
            hash2[key] = (hash2[key].to_datetime - 3.hour).in_time_zone('Moscow')
          else
            hash2[key] = hash2[key].to_datetime.in_time_zone('Moscow')
          end
        end
        comparison[key] = value unless hash2[key].to_s == value.to_s
      end
      comparison
    end

    def to_param(model_class_name)
      model_class_name.underscore.gsub '/', '_'
    end

    # FIXME remove when PG 9.4 with JSONB
    def transform_to_save(hash)
      hash&.each do |key, value|
        hash[key] = value.to_s if [DateTime, ActiveSupport::TimeWithZone].include? value.class
      end
      hash
    end
  end
end
