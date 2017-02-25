module Draper
  class CollectionDecorator
    delegate :current_page, :total_pages, :limit_value, :total_count

    def decorated_to_json(options = {})
      self.map do |obj|
        hash = obj.as_json options
        if options[:only].is_a? Array
          options[:only].each do |attribute|
            hash = add_to_hash_attributes obj, hash, attribute
          end
        else
          hash = add_to_hash_attributes obj, hash, options[:only]
        end
        hash.to_json
      end
    end

    private

    def add_to_hash_attributes(obj, hash, attribute)
      hash[attribute] = obj.send(attribute.to_s) unless hash.keys.include? attribute
      hash
    end
  end
end
