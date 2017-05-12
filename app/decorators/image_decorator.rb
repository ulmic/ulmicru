class ImageDecorator < ApplicationDecorator
  delegate_all

  def name
    object.file.url
  end

  def present_author
    author ? author.decorate.short_name : author_name
  end
end
