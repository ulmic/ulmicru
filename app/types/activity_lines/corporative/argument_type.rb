class ActivityLines::Corporative::ArgumentType < ::ActivityLines::Corporative::Argument
  include ApplicationType

  permit :text, :confession_id, :argument_type, :member_id
end
