# -*- coding: utf-8 -*-
class ApplicationReform < Reform::Form
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

    def find_with_model_by! *args
      obj = obj_class.find_by!(*args)
      self.new obj
    end

    def new_with_model *args
      obj = obj_class.new *args
      active_form = self.new obj
      active_form
    end

    def obj_class
      self.model_name.name.constantize
    end
  end

  def submit(params)
    raise 'ApplicationForm::Params should not be nil' unless params
    save if validate params
  end
end
