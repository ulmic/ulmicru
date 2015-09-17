FactoryGirl.define do
  factory :banner do
    horizontal { generate :image }
    link { generate :url }
    begin_date { DateTime.now }
    end_date { DateTime.now + 1.day }
    state { Banner.state_machines[:state].states.map(&:name).first.to_s }
  end
end
