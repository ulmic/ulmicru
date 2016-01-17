class RightConfirmationValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if (confirmed = record.send("#{attribute}_confirmation")) && (value != confirmed)
      human_attribute_name = record.class.human_attribute_name(attribute)
      record.errors.add(:"#{attribute}", :confirmation, options.merge(attribute: human_attribute_name))
    end
  end
end
