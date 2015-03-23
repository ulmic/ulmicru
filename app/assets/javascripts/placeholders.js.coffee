$ ->
  localize_placeholder = ($input) ->
    form_id = $input.closest('form').attr('id')
    action = form_id.split('_')[0]
    model_name = form_id.split('_')[1]
    attribute = $input.attr('id').substring $input.attr('id').indexOf('_') + 1
    placeholder = I18n.t("forms.placeholders.web.#{model_name}.#{action}.#{attribute}")
    if placeholder.match(/^\[missing.*\]/)
      placeholder = I18n.t("forms.placeholders.web.#{model_name}.default.#{attribute}")
    placeholder

  $('input[placeholder=locale]').each ->
    $(this).prop 'placeholder', localize_placeholder($(this))
    return
  return
