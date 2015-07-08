FactoryGirl.define do
  factory :tag do
    text { generate :string }
    tag_type :link
    record_id { News.last ? News.last.id : 1 }
    record_type 'News'
    target_id { Member.last ? Member.last.id : 1 }
    target_type 'Member'
  end
end
