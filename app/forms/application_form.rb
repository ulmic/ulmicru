# -*- coding: utf-8 -*-
class ApplicationForm < ActiveForm::Base
  extend FormDelegator

  def self.inherited(base)
    delegate_all_class(base)
    straightforward_delegates(base)
  end

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

    def obj_class
      main_model_name = self.main_model.to_s
      main_model_name = main_model_name.camelize if main_model_name.include? '_'
      if main_model_name.include? '/'
        names = main_model_name.split '/'
        main_model_name = names.collect { |name| name.capitalize! }.join('::')
      end
      main_model_name.capitalize! unless main_model_name[0].match /[A-Z]/
      Object.const_get main_model_name
    end
  end
end
