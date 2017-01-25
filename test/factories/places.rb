FactoryGirl.define do
  factory :place do
    title { generate :string }
    description { generate :string }
    foursquare_uid { generate :string }
    latitude { generate :string }
    longitude { generate :string }
    url
    state { Place.state_machines[:state].states.map(&:name).first.to_s }
  end
end
