FactoryGirl.define do
  factory :feedback do
    user_id { create(:user).id }
    url { generate :url }
    text { generate :string }
    state { Feedback.state_machines[:state].states.map(&:name).first.to_s }
  end
end
