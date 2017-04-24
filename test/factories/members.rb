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
    state { Member.state_machines[:state].states.map(&:name).except(:unavailable).sample }
    member_state { Member.state_machines[:member_state].states.map(&:name).sample }
    role 'user'
    type 'Member'
    questionary_state { User.state_machines[:questionary_state].states.map(&:name).sample.to_s }
    email_state { User.state_machines[:email_state].states.map(&:name).sample.to_s }

    trait :corporate_head do
      ticket 238
    end

    trait :with_views do
      after(:create) do
        create_list :view, 20
      end
    end
  end
end
