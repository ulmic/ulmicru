FactoryGirl.define do
  factory :member do
    first_name { generate :human_name }
    last_name { generate :human_name }
    email
    patronymic { generate :human_name }
    motto { generate :string }
    ticket { generate :integer }
    parent_id 1
    mobile_phone { generate :phone }
    birth_date { generate :date }
    home_adress { generate :string }
    avatar { generate :file }
    password { generate :string }
    password_confirmation { password }
  end
end
