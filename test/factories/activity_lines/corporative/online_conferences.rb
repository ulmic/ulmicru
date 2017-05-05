FactoryGirl.define do
  factory :activity_lines_corporative_online_conference, class: 'ActivityLines::Corporative::OnlineConference' do
    title { generate :string }
    date { generate :datetime }
    video_link 'https://youtu.be/someURL' 
    state { ::ActivityLines::Corporative::OnlineConference.state_machines[:state].states.map(&:name).first.to_s }
    event_id { Event.last&.id || create(:event).id }
  end
end
