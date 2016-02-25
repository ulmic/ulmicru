FactoryGirl.define do
  factory :delivery_campaign, class: 'Delivery::Campaign' do
    title { generate :string }
    body { generate :string }
    image
    link { generate :url }
    creator_id { Member.last ? Member.last.id : create(:member).id }
    mailing_date { DateTime.now }
    state { Delivery::Campaign.state_machines[:state].states.map(&:name).first.to_s }

    after :create do |campaign|
      create :delivery_audience, campaign_id: campaign.id
    end
  end
end
