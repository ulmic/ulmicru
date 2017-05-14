FactoryGirl.define do
  factory :user do
    first_name { generate :name }
    last_name { generate :name }
    patronymic { generate :name }
    email
    password { generate :password }
    password_confirmation { password }
    state { User.state_machines[:state].states.map(&:name).first.to_s }
    member_state { User.state_machines[:state].states.map(&:name).first.to_s }
    role { 'user' }
    questionary_state { User.state_machines[:questionary_state].states.map(&:name).sample.to_s }
    email_state { User.state_machines[:email_state].states.map(&:name).sample.to_s }

    trait :male do
      first_name 'Павел'
    end

    trait :female do
      first_name 'Мария'
    end
  end
end
