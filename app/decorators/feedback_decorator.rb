class FeedbackDecorator < ApplicationDecorator
  delegate_all

  decorates_association :user

  def date
    I18n.l object.created_at, format: '%d %b'
  end

  def self.collections
    [ :unviewed, :fixing, :done, :declined ]
  end
end
