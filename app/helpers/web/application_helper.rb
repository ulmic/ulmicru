module Web::ApplicationHelper
  include PositionList

  def positions_list
    PositionList.list
  end

  def tel_tag(telephone, html_options = nil, &block)
    link_to telephone, "tel:#{telephone}", html_options, &block
  end

  def image_input(form, form_instance, image_attribute_name)
    form.label image_attribute_name
    content_tag :div, class: :preview do
      image_tag form_instance.try image_attribute_name
    end
    form.input image_attribute_name, as: :file, label: false, input_html: { style: 'display: none' }
    form.input image_attribute_name, label: false, as: :jasny_file_preview_upload
  end
end
