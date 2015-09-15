FactoryGirl.define do
  factory :member do
    first_name { generate :human_name }
    last_name { generate :human_name }
    email
    patronymic { generate :human_name }
    motto { generate :string }
    ticket { generate :integer }
    parent_id { Member.last ? Member.last.id : 1 }
    mobile_phone { generate :phone }
    birth_date { generate :date }
    home_adress { generate :string }
    avatar { generate :file }
    password { generate :string }
    password_confirmation { password }
    municipality 'г. Ульяновск'
    locality 'г. Ульяновск'
    state { Member.state_machines[:state].states.map(&:name).first.to_s }
    member_state { Member.state_machines[:member_state].states.map(&:name).first.to_s }
    role 'user'
    type 'Member'
  end
end
