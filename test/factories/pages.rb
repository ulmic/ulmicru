FactoryGirl.define do
  factory :page do
    title { generate :string }
    view { generate :string }
    size { generate :string }
    text { generate :string }
    slug { generate :string }
  end
end
