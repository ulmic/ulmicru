FactoryGirl.define do
  factory :activity_lines_corporative_merit, class: 'ActivityLines::Corporative::Merit' do
    user_id { User.last&.id || create(:user).id }
    nomination { ::ActivityLines::Corporative::Merit.nomination.values.sample }
    year { generate :integer }
    state { ActivityLines::Corporative::Merit.state_machines[:state].states.map(&:name).first.to_s }
  end
end
