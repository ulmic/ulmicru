FactoryGirl.define do
  factory :document do
    file { generate :file }
    title { generate :string }
    state { Document.state_machines[:state].states.map(&:name).first.to_s }
  end
end
