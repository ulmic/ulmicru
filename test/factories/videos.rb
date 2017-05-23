FactoryGirl.define do
  factory :video do
    link { generate :url }
    title { generate :string }
    state { Video.state_machines[:state].states.map(&:name).first.to_s }
  end
end
