require 'naturally'

module Web::PagesHelper
  def wrap_anchors(text)
    urls = %r{(?:https?|ftp|mailto)://\S+}i
    html = text.gsub urls, '<a href="\0">\0</a>'
  end
end
