FactoryGirl.define do
  factory :comment do
    text { generate :string }
    record_id { News.last ? News.last.id : 1 }
    record_type 'News'
    user_id { User.last ? User.last.id : 1 }
    parent_id { Comment.last ? Comment.last.id : 1 }
  end
end
