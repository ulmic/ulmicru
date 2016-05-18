FactoryGirl.define do
  factory :image do
    file { generate :image_as_file }
    date { DateTime.now }
    author_id { User.last ? User.last.id : create(:user) }
    author_name { generate :human_name }
    image_type { Image.image_type.values.sample }
    state { Image.state_machines[:state].states.map(&:name).first.to_s }
  end
end
