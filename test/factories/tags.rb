FactoryGirl.define do
  factory :tag do
    text { generate :string }
    tag_type :link
    record_id { News.last ? News.last.id : create(:news).id }
    record_type 'News'
    target_id { Member.last ? Member.last.id : create(:member).id }
    target_type 'Member'
  end
end
