FactoryGirl.define do
  factory :delivery_contact_email, class: 'Delivery::ContactEmail' do
    email
    first_name { generate :human_name }
    last_name { generate :human_name }
  end

  factory 'delivery/contact_email', parent: :delivery_contact_email
end
