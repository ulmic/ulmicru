FactoryGirl.define do
  factory :document do
    file { generate :file }
    title { generate :string }
  end
end
