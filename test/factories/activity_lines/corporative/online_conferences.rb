FactoryGirl.define do
  factory :activity_lines_corporative_online_conference, class: 'ActivityLines::Corporative::OnlineConference' do
    title { generate :string }
    date { generate :datetime }
    video_link { generate :url }
    state { ::ActivityLines::Corporative::OnlineConference.state_machines[:state].states.map(&:name).first.to_s }
  end
end
