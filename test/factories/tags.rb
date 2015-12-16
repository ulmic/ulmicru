FactoryGirl.define do
  factory :tag do
    text { generate :string }
    tag_type :link
    record_type ['News', 'Article'].sample
    record_id do
      create(record_type.underscore).id
    end
    target_type ['Member', 'Team', 'ActivityLine', 'Event'].sample
    target_id do
      create(target_type.underscore).id
    end
    trait :new_target do
      target_id { create(target_type.underscore).id }
    end
  end
end
