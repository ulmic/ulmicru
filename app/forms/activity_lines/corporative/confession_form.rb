class ActivityLines::Corporative::ConfessionForm < ApplicationReform
  properties :year, :member_id, :state, :nomination, :creator_id, :state_event

  collection :arguments, populate_if_empty: ActivityLines::Corporative::Argument do
    properties :id, :argument_type, :text, :member_id, :confession_id
  end

  def build_arguments_for_petition
    argument_types = ::ActivityLines::Corporative::Argument.argument_type.values
    argument_types.each do |type|
      arguments << model.arguments.build(argument_type: type)
    end
  end
end
