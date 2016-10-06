class UlmicEmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.present?
      unless value =~ /.*@ulmic.ru$/
        record.errors.add(attribute, :corporate_email, options.merge(value: value))
      end
    end
  end
end
