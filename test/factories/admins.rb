FactoryGirl.define do
  factory :admin, parent: :user do
    role :admin
  end
end
