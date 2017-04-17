FactoryGirl.define do
  factory :view do
    record_type { View.record_type.values.sample  }
    record_id { record_type.constantize.last&.id || create(record_type.underscore) }
    user_id { User.last&.id || create(:user).id }
  end
end
