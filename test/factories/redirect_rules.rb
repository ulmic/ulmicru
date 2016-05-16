FactoryGirl.define do
  factory :redirect_rule do
    old_path { generate :url }
    redirect_to { generate :url }
    state { RedirectRule.state_machines[:state].states.map(&:name).sample.to_s }
    status { RedirectRule.status.values.sample }
    reason { generate :string }
  end
end
