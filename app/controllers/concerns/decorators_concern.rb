module Concerns
  module DecoratorsConcern
    def decorator_name
      "#{controller_name.classify}Decorator"
    end

    def decorator_class
      decorator_name.constantize
    end
  end
end
