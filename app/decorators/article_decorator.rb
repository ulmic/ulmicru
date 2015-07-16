class ArticleDecorator < ApplicationDecorator
  delegate_all

  def short_body
    "#{strip_tags(object.body)[0..50]}..." if object.body
  end

  def name
    title
  end

  alias :lead :short_body
end
