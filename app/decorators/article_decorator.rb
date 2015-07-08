class ArticleDecorator < ApplicationDecorator
  delegate_all

  def short_body
    "#{ActionController::Base.helpers.strip_tags(object.body)[0..50]}..." if object.body
  end

  def name
    title
  end
end
