class PasswordFoundationInput < SimpleForm::Inputs::StringInput
  def input(wrapper_options)
    value = object.send(attribute_name) if object.respond_to? attribute_name
    input_html_options[:type] = 'password'

    button = template.content_tag :div, class: 'small-1 columns input' do
      template.content_tag :a, href: '#', class: 'button postfix eye', type: 'button' do
        template.content_tag :span, '', class: 'fa fa-eye'
      end
    end
    password_input = template.content_tag :div, class: 'small-11 columns input'  do
      super(wrapper_options)
    end
    template.content_tag :div, class: 'row-fluid' do
      password_input + button
    end
  end

  def input_html_classes
    super.push ''   # 'form-control'
  end
end
