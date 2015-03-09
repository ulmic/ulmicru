class ApplicationForm < ActiveForm::Base
  class << self

    def find_with_model *args
      obj = obj_class.find(*args)
      self.new obj
    end

    def find_with_model_by *args
      obj = obj_class.find_by(*args)
      self.new obj
    end

    def new_with_model *args
      obj = obj_class.new(*args)
      self.new obj
    end

    private

    def obj_class
      Object.const_get(self.main_model.capitalize)
    end
  end
end
