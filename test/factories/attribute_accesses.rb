FactoryGirl.define do
  factory :attribute_access do
    member_id { create(:member).id }
    member_attribute { generate :string }
    access 'hidden'
  end
end
