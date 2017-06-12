FactoryGirl.define do
  factory :click do
    url
    html_id { generate :string }
    page_url { generate :url }
    user_id { User.last&.id || create(:user).id }
  end
end
