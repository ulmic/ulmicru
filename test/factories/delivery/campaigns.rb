FactoryGirl.define do
  factory :delivery_campaign, class: 'Delivery::Campaign' do
    title { generate :string }
    body { generate :string }
    image { generate :file }
    link { generate :url }
    creator_id { User.last ? User.last.id : create(:user).id }
    mailing_date { DateTime.now }
    state { Delivery::Campaign.state_machines[:state].states.map(&:name).first.to_s }
  end
end
