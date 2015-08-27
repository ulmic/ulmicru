FactoryGirl.define do
  factory :authentication do
    uid { generate :string }
    user_id { User.last ? User.last.id : create(:user).id }
    provider :facebook
  end
end
