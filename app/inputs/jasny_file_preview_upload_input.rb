class JasnyFilePreviewUploadInput < SimpleForm::Inputs::FileInput
  #FIXME fix using this input
  def initialize(*args)
    @button ||= 'btn'
    @default_button ||= 'btn-default'
    super *args
  end

  def input(wrapper_options)
    model_name = object.model.model_name.name.underscore.gsub '/', '_'
    template.content_tag :div, class: 'fileinput fileinput-new', data: { provides: :fileinput } do
      input = template.content_tag :div, class: 'fileinput-preview thumbnail', data: { trigger: :fileinput }, style: 'width: 200px; height: 150px' do
      end
      input += template.content_tag :div do
        span = template.content_tag :span, class: "#{@button} #{@default_button} btn-file" do
          inside_span = template.content_tag :span, class: 'fileinput-new' do
            I18n.t('helpers.links.select_image')
          end
          inside_span += template.content_tag :span, class: 'fileinput-exists' do
            I18n.t('helpers.links.change')
          end
          inside_span += template.content_tag :input, class: 'file',
                                               id: "#{model_name}_#{attribute_name}",
                                               name: "#{model_name}[#{attribute_name}]",
                                               type: :file do
          end
          inside_span
        end
        span += template.content_tag :a, class: "#{@button} #{@default_button} fileinput-exists remove", data: { dismiss: :fileinput }, href: '#' do
          I18n.t('helpers.links.remove')
        end
        span
      end
      input
    end
  end
end
