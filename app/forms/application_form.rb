class ApplicationForm < ActiveForm::Base

  class << self
    delegate :human_attribute_name, to: :obj_class # for locales
    delegate :enumerized_attributes, to: :obj_class # for enumerize simple form integration

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
