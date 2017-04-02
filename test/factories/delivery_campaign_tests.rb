FactoryGirl.define do
  factory :delivery_campaign_test, :class => 'Delivery::Campaign::Test' do
    campaign_id 1
receiver_id 1
result "MyText"
  end

end
