module Concerns
  module ParamsComparingConcern
    def log_params
      case action_name
      when 'update'
        object = model_class.find(params[:id])
        new_params = params[to_param(model_class.name)]
        attributes = object_attributes_with_associations object, new_params
        attributes_diff attributes.except(*not_logged_attributes), @prev_object_attributes
      when 'create'
        params[to_param(model_class.name)]
      end
    end

    def attributes_diff(object_hash, prev_object_hash)
      comparing prev_object_hash, object_hash
    end

    def object_attributes_with_associations(object, params)
      attributes = object.attributes
      unless action_name == 'destroy'
        params.keys.each do |key|
          if key.to_s.include? 'attributes'
            association_attributes_hash = {}
            association_name = key.split('_')[0]
            association_attributes_hash.merge!(object.send(association_name).reduce({}) do |a_hash, ass|
              a_hash.merge! ass.id => ass.attributes
            end)
            attributes.merge! association_name => association_attributes_hash
          end
        end
      end
      attributes
    end

    def comparing(hash1, hash2)
      hash1 = transfrom_object_hash hash1
      hash2 = transfrom_object_hash hash2
      HashDiff.diff hash1.compact, hash2.compact
    end

    def transfrom_object_hash(hash)
      hash.except! *not_logged_attributes, 'id'
      to_s_keys_hash = {}
      hash.each do |key, value|
        if key.is_a? Integer
          to_s_keys_hash.merge! key.to_s => value
        else
          to_s_keys_hash.merge! key => value
        end
      end
      hash = to_s_keys_hash
      hash.each do |key, value|
        if !value.is_a?(String) && !value.is_a?(Hash)
          hash[key] = value.to_s
        end
        if value.is_a? Hash
          nested_hash = value.except *not_logged_attributes, "#{model_class.name.to_s.underscore}_id"
          nested_hash.each do |v_key, v_value|
            nested_hash[v_key] = v_value.to_s
          end
          hash[key] = nested_hash
        end
      end
      hash
    end

    def to_param(model_class_name)
      if take_member_action?
        'questionary'
      else
        model_class_name.underscore.gsub '/', '_'
      end
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
