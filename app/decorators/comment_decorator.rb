class CommentDecorator < ApplicationDecorator
  delegate_all

  def short_name
    object.user.decorate.short_name
  end
end
