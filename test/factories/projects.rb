FactoryGirl.define do
  factory :project do
    title { generate :string }
    url
    project_type { Project.project_type.values.sample }
    state { Project.state_machines[:state].states.map(&:name).first.to_s }
  end
end
