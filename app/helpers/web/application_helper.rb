module Web::ApplicationHelper
  include PositionList

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

  def stylesheet_link_tag_if_exists(link)
    stylesheet_link_tag link if Ulmicru::Application.assets.find_asset link
  end

  def javascript_include_tag_if_exists(link)
    javascript_include_tag link if Ulmicru::Application.assets.find_asset link
  end

  def hint(model_name, attribute_name, place:)
    case place
    when :admin
      content_tag :div, class: 'alert alert-dissmissible alert-info' do
        concat fa_icon 'info-circle'
        concat ' '
        concat t("hints.admin.#{model_name.to_s.underscore}.#{attribute_name}")
      end
    when :face
      content_tag :div, class: 'panel panel-info' do
        concat fa_icon 'info-circle'
        concat ' '
        concat t("hints.#{model_name.to_s.underscore}.#{attribute_name}")
      end
    end
  end
end
