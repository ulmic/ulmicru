FactoryGirl.define do
  factory :user do
    email
    password { generate :string }
  end
end
