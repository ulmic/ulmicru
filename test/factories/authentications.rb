FactoryGirl.define do
  factory :authentication do
    uid { generate :string }
    user_id { User.last ? User.last.id : 1 }
    provider :facebook
  end
end
