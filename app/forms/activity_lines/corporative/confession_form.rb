class ActivityLines::Corporative::ConfessionForm < ApplicationForm
  attributes :year, :member_id, :state, :nomination

  association :arguments do
    attributes :id, :argument_type, :text, :member_id, :confession_id
  end

  def build_arguments_for_petition
    argument_types = ::ActivityLines::Corporative::Argument.argument_type.values
    arguments.push arguments.first.dup while arguments.count < argument_types.count
    argument_types.each_with_index do |a_type, index|
      arguments[index].model.argument_type = a_type
    end
  end
end
