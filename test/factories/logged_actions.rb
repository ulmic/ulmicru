FactoryGirl.define do
  factory :logged_action do
    user_id 1
action_type "MyText"
record_type "MyText"
record_id 1
params "MyText"
  end

end
