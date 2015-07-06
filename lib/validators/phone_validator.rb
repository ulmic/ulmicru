class PhoneValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /^\+|8\d{,3}[\s\(-]*\d{3}[\s\)-]*[\d\s-]*$/
      record.errors.add(attribute, :phone, options.merge(value: value))
    end
  end
end
