FactoryGirl.define do
  factory :events_online_conference, class: 'Events::OnlineConference' do
    title { generate :string }
    date { generate :datetime }
    video_link { generate :url }
    state { ::Events::OnlineConference.state_machines[:state].states.map(&:name).first.to_s }
  end
end
