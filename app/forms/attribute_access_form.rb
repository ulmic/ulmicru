class AttributeAccessForm < ApplicationForm
  self.main_model = :attribute_access

  attribute :member_attribute, :member_id, :access
end
