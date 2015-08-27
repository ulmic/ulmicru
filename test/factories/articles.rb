FactoryGirl.define do
  factory :article do
    title       { generate :string }
    body        { generate :string }
    view        nil
    category_id { Category.first ? Category.first.id : create(:category).id }
    association :user
    user_id     { User.last ? User.last.id : create(:user).id }

    trait :contacts do
      title 'Контакты'
      association :category, :contacts
    end
  end
end
