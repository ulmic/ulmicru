FactoryGirl.define do
  factory :questionary do
    first_name { generate :human_name }
    last_name { generate :human_name }
    email
    patronymic { generate :human_name }
    motto { generate :string }
    ticket { generate :integer }
    mobile_phone { generate :phone }
    birth_date { generate :date }
    home_adress { generate :string }
    avatar { generate :image }
    experience { generate :string }
    want_to_do { generate :string }
    state { Questionary.state_machines[:state].states.map(&:name).first.to_s }
    member_state { Questionary.state_machines[:member_state].states.map(&:name).first.to_s }
    password { generate :password }
    role { Questionary.role.values.first }
    password_confirmation { password }
    type 'Questionary'
    municipality 'г. Ульяновск'
    locality 'г. Ульяновск'
  end
end
