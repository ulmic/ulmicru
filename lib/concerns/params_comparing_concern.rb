module Concerns
  module ParamsComparingConcern
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
  end
end
