FactoryGirl.define do
  factory :comment do
    text { generate :string }
    record_id { News.last ? News.last.id : create(:news).id }
    record_type 'News'
    user_id { User.last ? User.last.id : create(:user).id }
    parent_id { Comment.last ? Comment.last.id : 1 }
    state { Comment.state_machines[:state].states.map(&:name).first.to_s }
  end
end
