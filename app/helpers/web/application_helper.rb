module Web::ApplicationHelper
  include PositionList

  def positions_list
    PositionList.list
  end

  def tel_tag(telephone, html_options = nil, &block)
    link_to telephone, "tel:#{telephone}", html_options, &block
  end
end
