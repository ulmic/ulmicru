class TeamDecorator < ApplicationDecorator
  delegate_all

  decorates_association :users

  def short_description
    "#{strip_tags(model.description)[0..50]}..."
  end

  def head_name
    member.decorate.short_name if member
  end

  def name
    title
  end

  def self.collections
    [ :active, :unviewed, :closed, :removed ]
  end
end
