FactoryGirl.define do
  factory :news do
    title        { generate :string }
    body         { generate :string }
    published_at { DateTime.now }
    photo        { generate :image }
    lead         { generate :string }
    user_id      { create(:member).id }
    state { News.state_machines[:state].states.map(&:name).first.to_s }
    views { generate :integer }
  end
end
