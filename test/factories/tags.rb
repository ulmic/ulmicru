FactoryGirl.define do
  factory :tag do
    text { generate :string }
    tag_type :link
    record_type ['News', 'Article'].sample
    record_id do
      record_class = record_type.constantize;
      record_class.last ? record_class.last.id : create(record_type.underscore).id
    end
    target_type ['Member', 'Team', 'ActivityLine', 'Event'].sample
    target_id do
      target_class = target_type.constantize
      target_class.last ? target_class.last.id : create(target_type.underscore).id
    end
    trait :new_target do
      target_id { create(target_type.underscore).id }
    end
  end
end
