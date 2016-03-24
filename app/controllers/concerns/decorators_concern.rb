module Concerns
  module DecoratorsConcern
    def decorator_name
      "#{controller_path.sub('web/admin/', '').classify}Decorator"
    end

    def decorator_class
      decorator_name.constantize
    end
  end
end
