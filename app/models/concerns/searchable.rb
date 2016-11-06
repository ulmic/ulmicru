module Concerns
  module Searchable
    extend ActiveSupport::Concern

    module ClassMethods
      def search_against(*attrs)
        @search_attributes = attrs
        define_singleton_method :search do |query|
          sql = @search_attributes.map do |attr|
            "#{attr} ILIKE '%#{query}%'"
          end.join(' OR ')
          self.where sql
        end
      end
    end
  end
end
