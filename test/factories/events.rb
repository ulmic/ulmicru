FactoryGirl.define do
  factory :event do
    title { generate :string }
    description { generate :string }
    main_photo { generate :file }
    creator_id { Member.last ? Member.last.id : 1 }
    begin_date { DateTime.now }
    end_date { DateTime.now + 1.day }
    activity_line_id { ActivityLine.last ? ActivityLine.last.id : 1 }
    place '4e3faf5ac65b4ec275ff0a3b'
  end
end
