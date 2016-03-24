class CommentDecorator < ApplicationDecorator
  delegate_all

  decorates_association :user

  def self.collections
    [ :unviewed, :active ]
  end
end
