FactoryGirl.define do
  factory :argument, class: 'ActivityLines::Corporative::Argument' do
    text { generate :string }
    argument_type { ActivityLines::Corporative::Argument.argument_type.values.first }
    member_id { Member.last ? Member.last.id : create(:member).id }
    confession_id do
      class_name = ::ActivityLines::Corporative::Confession
      class_name.last ? class_name.last.id : create(:confession).id
    end
  end
end
