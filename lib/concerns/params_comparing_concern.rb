module Concerns
  module ParamsComparingConcern
    def log_params
      case action_name
      when 'update'
        object = model_class.find(params[:id])
        new_params = params[to_param(model_class.name)]
        attributes = object_attributes_with_associations object, new_params
        attributes_diff attributes.except(*not_logged_attributes), new_params, @prev_object_attributes
      when 'create'
        params[to_param(model_class.name)]
      end
    end

    def attributes_diff(object_hash, params, prev_object_hash)
      binding.pry
      if comparing(object_hash, params) == []
        comparing object_hash, prev_object_hash, :prev_object
      end
    end

    def object_attributes_with_associations(object, params)
      attributes = object.attributes
      unless action_name == 'destroy'
        params.keys.each do |key|
          if key.to_s.include? 'attributes'
            attributes.merge!(object.send(key.split('_')[0]).reduce({}) do |a_hash, ass|
              a_hash.merge! ass.id => ass.attributes
            end)
          end
        end
      end
      attributes
    end

    def comparing(hash1, hash2, prev_object = nil)
      hash1.except!('id', 'updated_at')
      to_s_keys_hash = {}
      hash1.each do |key, value|
        if key.is_a? Integer
          to_s_keys_hash.merge! key.to_s => value
        else
          to_s_keys_hash.merge! key => value
        end
      end
      hash1 = to_s_keys_hash
      hash1.each do |key, value|
        if !value.is_a?(String) && !value.is_a?(Hash)
          hash1[key] = value.to_s
        end
        if value.is_a? Hash
          nested_hash = value.except *not_logged_attributes, "#{model_class.name.to_s.underscore}_id"
          nested_hash.each do |v_key, v_value|
            nested_hash[v_key] = v_value.to_s
          end
          hash1[key] = nested_hash
        end
      end
      nested_attributes = {}
      hash2.each do |key, value|
        if value.include?('/') && Date.valid_date?(*value.split('/').reverse.map(&:to_i))
          if value.to_datetime.to_s.include?("+00")
            hash2[key] = (hash2[key].to_datetime - 3.hour).in_time_zone('Moscow').to_s
          end
        end
        if value.is_a?(Hash) && key.to_s.include?('attributes')
          value.each do |v_key, v_value|
            id = v_value['id']
            nested_attributes.merge! id => v_value.except(*not_logged_attributes)
          end
          hash2[key] = nil
        end
      end
      hash2.merge! nested_attributes
      HashDiff.diff hash1.compact, hash2.compact
    end

    def recursive_to_s(hash)
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
