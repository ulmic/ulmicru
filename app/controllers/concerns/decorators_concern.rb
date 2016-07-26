module Concerns
  module DecoratorsConcern
    def decorator_name(model_class = nil)
      model_class ||= controller_path.sub('web/admin/', '').classify
      "#{model_class}Decorator"
    end

    def decorator_class(model_class = nil)
      decorator_name(model_class).constantize
    end
  end
end
