FactoryGirl.define do
  factory :member do
    patronymic { generate :human_name }
    motto { generate :string }
    ticket { generate :integer }
    parent_id 1
    mobile_phone { generate :phone }
    birth_date { generate :date }
    home_adress { generate :string }
    municipality { generate :string }
    locality { generate :string }
    avatar { generate :string }
  end
end
