FactoryGirl.define do
  factory :event do
    title { generate :string }
    description { generate :string }
    main_photo { generate :image }
    creator_id { Member.last ? Member.last.id : create(:member).id }
    begin_date { DateTime.now }
    end_date { DateTime.now + 1.day }
    activity_line_id { ActivityLine.last ? ActivityLine.last.id : create(:activity_line).id }
    place '4e3faf5ac65b4ec275ff0a3b'
    organizer_type 'Team'
    organizer_id { Team.last ? Team.last.id : create(:team).id }
    state { Event.state_machines[:state].states.map(&:name).first.to_s }
  end
end
