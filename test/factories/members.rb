FactoryGirl.define do
  factory :member do
    patronymic { generate :human_name }
    association :user
    user_id { User.last ? User.last.id : 1 }
    motto { generate :string }
    ticket_number { generate :integer }
    parent_id 1
    mobile_phone { generate :phone }
    birth_date { generate :date }
    home_adress { generate :string }
    municipality { generate :string }
    locality { generate :string }
    avatar { generate :string }
  end
end
