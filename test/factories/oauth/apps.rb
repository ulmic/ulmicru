FactoryGirl.define do
  factory :oauth_app, class: 'Oauth::App' do
    title { generate :string }
    client_id { generate :string }
    client_secret { generate :string }
    url { generate :url }
    callback_url { generate :url }
    state { Oauth::App.state_machines[:state].states.map(&:name).first.to_s }
  end
end
