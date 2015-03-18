FactoryGirl.define do
  factory :news do
    title        { generate :string }
    body         { generate :string }
    published_at { DateTime.now }
    photo        { generate :file }
    lead         { generate :string }
    user_id      { User.last ? User.last.id : 1 }
  end
end
