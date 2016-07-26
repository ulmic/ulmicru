class FeedbackDecorator < ApplicationDecorator
  delegate_all

  decorates_association :user

  def self.collections
    [ :unviewed, :fixing, :done, :declined ]
  end
end
