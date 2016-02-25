FactoryGirl.define do
  factory :delivery_audience, class: 'Delivery::Audience' do
    audience_type :team
    audience_id { create(:team_with_teammates).id }
  end
end
