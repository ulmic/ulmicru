FactoryGirl.define do
  factory :category do
    name { generate :string }
    parent_id { Category.last ? Category.last.id : 1 }
    state { Category.state_machines[:state].states.map(&:name).first.to_s }

    trait :contacts do
      name 'Контакты'
    end
  end
end
