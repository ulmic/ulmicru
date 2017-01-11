FactoryGirl.define do
  factory :member do
    first_name { generate :human_name }
    last_name { generate :human_name }
    email
    patronymic { generate :human_name }
    motto { generate :string }
    ticket { Member.where.not(ticket: nil).any? ? Member.where.not(ticket: nil).order(:ticket).last.ticket + 1 : generate(:integer) }
    parent_id { Member.last ? Member.last.id : nil }
    mobile_phone { generate :phone }
    birth_date { generate :datetime }
    home_adress { generate :string }
    avatar { generate :image_as_file }
    password { generate :password }
    password_confirmation { password }
    municipality { Member.municipality.values.first } 
    locality { Member.locality.values.first }
    state { Member.state_machines[:state].states.map(&:name).sample }
    member_state { Member.state_machines[:member_state].states.map(&:name).sample }
    role 'user'
    type 'Member'

    trait :corporate_head do
      ticket 238
    end
  end
end
