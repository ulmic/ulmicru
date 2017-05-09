class ActivityLineDecorator < ApplicationDecorator
  delegate_all

  decorates_association :member

  def short_body
    "#{strip_tags(model.description)[0..50]}..."
  end

  def name
    title
  end

  def self.collections
    [ :active, :unviewed, :removed, :closed ]
  end
end
