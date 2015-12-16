FactoryGirl.define do
  factory :authentication do
    uid { generate :string }
    user_id { create(:user).id }
    provider :facebook
  end
end
