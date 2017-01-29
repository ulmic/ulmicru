class FeedbackDecorator < ApplicationDecorator
  delegate_all

  decorates_association :user

  def name
    if object.user
      "Обратная связь от #{object.user.decorate.short_name}"
    end
  end

  def date
    I18n.l object.created_at, format: '%d %b'
  end

  def self.collections
    [ :unviewed, :fixing, :done, :declined ]
  end
end
