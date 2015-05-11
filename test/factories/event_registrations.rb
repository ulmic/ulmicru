FactoryGirl.define do
  factory :event_registration, class: 'Event::Registration' do
    user_id { User.last ? User.last.id : 1 }
    event_id { Event.last ? Event.last.id : 1 }
    role { Event::Registration.role.values.first  }
  end
end
