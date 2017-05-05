FactoryGirl.define do
  factory :article do
    title       { generate :string }
    body        { generate :string }
    view        nil
    category_id { Category.last.id }
    user_id     { create(:user).id }
    state { Article.state_machines[:state].states.map(&:name).first.to_s }
    views { generate :integer }
    publicity { Article.publicity.values.sample }
    access { Article.access.values.sample }

    trait :contacts do
      title 'Контакты'
      association :category, :contacts
    end

    trait :charter do
      title 'Устав'
    end

    trait :with_own_view do
      view 'history'
    end
  end
end
