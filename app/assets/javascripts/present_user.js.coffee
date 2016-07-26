window.present_user = (model_name, user_type) ->
  $("##{model_name}_#{user_type}_id").change ->
    text = $(@).children('option:selected').text()
    text = text.split('|')[1].substring(2) unless text.indexOf('|') == -1
    $("##{model_name}_#{user_type}_name").val text
