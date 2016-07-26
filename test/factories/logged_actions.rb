FactoryGirl.define do
  factory :logged_action do
    user_id { Member.last ? Member.last.id : create(:member).id }
    action_type { LoggedAction.action_type.values.sample }
    record_type "Member"
    record_id { Member.last ? Member.last.id : create(:member).id }
    params { { first_name: :my_name } }
  end
end
