FactoryGirl.define do
  factory :news do
    title        { generate :string } 
    body         { generate :string } 
    published_at { DateTime.now }
    photo        { generate :file }
    author_id    { generate :integer }
  end
end
