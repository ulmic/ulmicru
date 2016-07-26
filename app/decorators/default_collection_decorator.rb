class DefaultCollectionDecorator < Draper::CollectionDecorator
  def with(*attributes)
    if object.any?
      decorator_class = "#{object.first.class}Decorator".constantize
      decorator_class.decorate_collection(object).map do |instance|
        attributes.map do |attribute|
          compile_attributes attribute, instance
        end.to_h
      end
    end
  end

  private

  def compile_attributes(attribute, instance)
    if attribute.is_a? Symbol
      [attribute, instance.send(attribute)]
    elsif attribute.is_a? Hash
      result = attribute.map do |key, value|
        arr = []
        arr << key
        if value.is_a? Proc
          arr << instance.instance_exec(&value)
        elsif value.is_a? Symbol
          arr << instance.send(value)
        elsif value.is_a? Hash
          arr << compile_attributes(value, instance).to_h
        end
        arr
      end
      # Hash count is 1 then use only first item of array
      attribute.count == 1 ? result.first : result
    end
  end
end
