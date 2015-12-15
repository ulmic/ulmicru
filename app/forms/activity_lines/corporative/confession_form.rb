class ActivityLines::Corporative::ConfessionForm < ApplicationForm
  attributes :year, :member_id, :state, :nomination

  association :arguments do
    attributes :id, :argument_type, :text, :member_id, :confession_id
  end
end
