class ArticleDecorator < ApplicationDecorator
  delegate_all

  def short_body
    "#{strip_tags(object.body)[0..50]}..." if object.body
  end

  def description_lead
    "#{model.body.first(200)}..."
  end

  def name
    title
  end

  alias :lead :short_body

  def self.collections
    [ :confirmed, :inactive, :unviewed ]
  end
end
