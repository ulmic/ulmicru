module Web::ApplicationHelper
  def tel_tag(telephone, html_options = nil, &block)
    link_to telephone, "tel:#{telephone}", html_options, &block
  end
end
