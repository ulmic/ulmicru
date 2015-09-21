class AttachmentPreviewInput < SimpleForm::Inputs::FileInput
  def input(wrapper_options = nil)
    out = ''
    if object.send("#{attribute_name}?")
      out << template.link_to(I18n.t('helpers.download'), object.send(attribute_name).url, class: 'btn btn-success btn-xs')
    end
    (out << super).html_safe
  end
end
