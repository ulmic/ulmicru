FactoryGirl.define do
  factory :feedback do
    user_id { User.last ? User.last.id : create(:user).id }
    url { generate :url }
    text { generate :string }
    state { Feedback.state_machines[:state].states.map(&:name).first.to_s }
  end
end
