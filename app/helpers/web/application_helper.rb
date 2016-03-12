module Web::ApplicationHelper
  include PositionList
  include HtmlTags

  def positions_list
    PositionList.list
  end

  def image_input(form, form_instance, image_attribute_name)
    concat form.label image_attribute_name
    concat(content_tag(:div, class: :preview) do
      image_tag form_instance.try image_attribute_name
    end)
    concat form.input image_attribute_name, as: :file, label: false, input_html: { style: 'display: none' }
    concat form.input image_attribute_name, label: false, as: :jasny_file_preview_upload
  end
end
