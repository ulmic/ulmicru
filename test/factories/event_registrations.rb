FactoryGirl.define do
  factory :event_registration, class: 'Event::Registration' do
    user_id { User.last ? User.last.id : create(:user).id }
    event_id { Event.last ? Event.last.id : create(:event).id }
    role { Event::Registration.role.values.first  }
  end
end
