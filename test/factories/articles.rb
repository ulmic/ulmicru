FactoryGirl.define do
  factory :article do
    title       { generate :string }
    body        { generate :string }
    view        nil
    category_id { create(:category).id }
    user_id     { create(:user).id }
    state { Article.state_machines[:state].states.map(&:name).first.to_s }
    views { generate :integer }

    trait :contacts do
      title 'Контакты'
      association :category, :contacts
    end

    trait :charter do
      title 'Устав'
    end
  end
end
