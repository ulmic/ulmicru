FactoryGirl.define do
  factory :questionary do
    patronymic { generate :human_name }
    motto { generate :string }
    ticket { generate :integer }
    parent_id 1
    mobile_phone { generate :phone }
    birth_date { generate :date }
    home_adress { generate :string }
    locality { generate :string }
    avatar { generate :string }
    experience { generate :string }
    want_to_do { generate :string }
    state 'unviewed'
    password { generate :string }
    password_confirmation { password }
  end
end
