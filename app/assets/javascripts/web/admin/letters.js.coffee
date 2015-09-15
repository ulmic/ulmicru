$ ->
  $('#letter_executor_id').change ->
    $('#letter_executor_name').val $(@).children('option:selected').text().split('|')[1].substring(2)
