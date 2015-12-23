class ActivityLines::Corporative::EditConfessionType < ::ActivityLines::Corporative::Confession
  include ApplicationType

  permit :year, :member_id, :state, :nomination, :creator_id,
          arguments_attributes: [
           :id, :argument_type, :text, :member_id, :confession_id
          ]

  def build_arguments_for_petition
    argument_types = ::ActivityLines::Corporative::Argument.argument_type.values
    argument_types.each do |type|
      arguments.build argument_type: type
    end
  end
end
