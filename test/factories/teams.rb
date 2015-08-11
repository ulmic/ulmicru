FactoryGirl.define do
  factory :team do
    title { generate :string }
    member_id { Member.last ? Member.last.id : 1 }
    description { generate :string }
  end

  factory :departament, parent: :team, class: 'Team::Departament'
  factory :primary, parent: :team, class: 'Team::Primary'
  factory :subdivision, parent: :team, class: 'Team::Subdivision'
  factory :administration, parent: :team, class: 'Team::Administration'
end
