FactoryGirl.define do
  factory :category do
    name { generate :string }
    parent_id { Category.last ? Category.last.id : nil }
    state { Category.state_machines[:state].states.map(&:name).first.to_s }
    id { Category.maximum(:id) + 1 }

    trait :contacts do
      name 'Контакты'
    end
  end
end
