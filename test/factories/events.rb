FactoryGirl.define do
  factory :event do
    title { generate :string }
    description { generate :string }
    main_photo { generate :image_as_file }
    creator_id { create(:member).id }
    begin_date { DateTime.now }
    end_date { DateTime.now + 1.day }
    activity_line_id { create(:activity_line).id }
    organizer_type 'Team'
    organizer_id { create(:team).id }
    state { Event.state_machines[:state].states.map(&:name).first.to_s }
    place_ids { create_list(:place, 5); Place.last(5).map(&:id) }
  end
end
