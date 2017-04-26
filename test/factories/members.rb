FactoryGirl.define do
  factory :member do
    first_name { generate :human_name }
    last_name { generate :human_name }
    email
    patronymic { generate :human_name }
    motto { generate :string }
    ticket do
      if Member.where.not(ticket: nil).any?
        Member.where.not(ticket: nil).order(:ticket).last.ticket + 1
      else
        generate(:integer)
      end
    end
    parent_id { Member.just_members.last&.id }
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
