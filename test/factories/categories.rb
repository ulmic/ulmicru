FactoryGirl.define do
  factory :category do
    name { generate :string }
    parent_id { Category.last ? Category.last.id : 1 }

    trait :contacts do
      name 'Контакты'
    end
  end
end
