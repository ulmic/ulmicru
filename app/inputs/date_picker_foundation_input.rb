class DatePickerFoundationInput < SimpleForm::Inputs::StringInput
  # FIXME it must works
  def input(wrapper_options)
    value = object.send(attribute_name) if object.respond_to? attribute_name
    display_pattern = I18n.t('datepicker.dformat', default: '%d/%m/%Y')

    input_html_options[:type] = 'text'
    picker_pattern = I18n.t('datepicker.pformat', default: 'DD/MM/YYYY')
    dayViewHeaderFormat = I18n.t('dayViewHeaderFormat', default: 'MMMM YYYY')
    date_options = {
      locale: I18n.locale.to_s,
      dayViewHeaderFormat: dayViewHeaderFormat,
      format: picker_pattern
    }
    input_html_options[:data] ||= {}
    input_html_options[:data].merge!({date_options: date_options })

    button = template.content_tag :div, class: 'small-1 columns input' do
      template.content_tag :a, href: '#', class: 'button postfix date_picker', type: 'button' do
        template.content_tag :span, '', class: 'fa fa-calendar'
      end
    end
    date_input = template.content_tag :div, class: 'small-11 columns input'  do
      super(wrapper_options)
    end
    template.content_tag :div, class: 'row-fluid' do
      date_input + button
    end
  end

  def input_html_classes
    super.push ''   # 'form-control'
  end
end
