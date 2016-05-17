class ImageDecorator < ApplicationDecorator
  delegate_all

  def self.collections
    [ :active, :removed ]
  end

  def present_author
    author ? author.decorate.short_name : author_name
  end
end
