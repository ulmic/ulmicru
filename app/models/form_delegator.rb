# -*- coding: utf-8 -*-
module FormDelegator
  # dark magic; delegate all methods from self.model to form
  def new(*args)
    obj = super(*args)

    obj.model.public_methods.select{ |m| !obj.respond_to?(m) }.each do |method|
      obj.class_eval do
        define_method method do |*args|
          obj.model.send method, *args
        end
      end
    end

    obj
  end

  # dark magic; delegate all methods from self.model.class to form.class
  def delegate_all_class(base)
    base.obj_class.public_methods.select{ |m| !base.respond_to?(m) }.each do |method|
      base.class_eval("class << self ; def #{method.to_s}(*args) ; self.obj_class.#{method.to_s} *args ; end ; end")
    end
  end

  # delegate для тех методов, которые однозначно должны скидываться на модель.
  def straightforward_delegates(base)
    base.class_eval("class << self ; delegate :human_attribute_name, to: :obj_class ; end")
  end
end
