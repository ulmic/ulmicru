FactoryGirl.define do
  factory :delivery_receiver, :class => 'Delivery::Receiver' do
    user_id 1
campaign_id 1
state "MyText"
  end

end
