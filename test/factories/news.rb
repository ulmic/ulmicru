FactoryGirl.define do
  factory :news do
    title        { generate :string }
    body         { generate :string }
    published_at { DateTime.now }
    photo        { generate :string }
    lead         { generate :string }
    user_id      { generate :integer }
  end
end
