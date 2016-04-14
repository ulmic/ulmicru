FactoryGirl.define do
  factory :user do
    first_name { generate :name }
    last_name { generate :name }
    patronymic { generate :name }
    email
    password { generate :password }
    password_confirmation { password }
    state { User.state_machines[:state].states.map(&:name).sample.to_s }
    member_state { User.state_machines[:state].states.map(&:name).sample.to_s }
    role { User.role.values.sample }
  end
end
