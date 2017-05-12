class CommentDecorator < ApplicationDecorator
  delegate_all

  decorates_association :user

  def name
    "#{user.decorate.short_name}: #{object.text} -> #{object.record.decorate.name}"
  end
end
