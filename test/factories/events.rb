FactoryGirl.define do
  factory :event do
    title "MyString"
    description "MyString"
    main_photo        { generate :file }
    creator_id 1
    begin_date "2015-03-06 14:36:16"
    end_date "2015-03-06 14:36:16"
    event_type "big"
  end
end
