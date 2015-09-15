FactoryGirl.define do
  factory :page do
    title { generate :string }
    view { generate :string }
    size { generate :string }
    text { generate :string }
    slug { generate :string }
    state { Page.state_machines[:state].states.map(&:name).first.to_s }
  end
end
