FactoryGirl.define do
  factory :questionary do
    first_name { generate :human_name }
    last_name { generate :human_name }
    email
    patronymic { generate :human_name }
    motto { generate :string }
    mobile_phone { generate :phone }
    birth_date { generate :datetime }
    home_adress { generate :string }
    avatar { generate :image_as_file }
    experience { generate :string }
    want_to_do { generate :string }
    state { Questionary.state_machines[:state].states.map(&:name).sample.to_s }
    member_state { Questionary.state_machines[:member_state].states.map(&:name).except(:confirmed).sample.to_s }
    password
    role { Questionary.role.values.first }
    password_confirmation { password }
    type 'Questionary'
    municipality { Member.municipality.values.sample }
    locality { Member.locality.values.sample }
  end
end
