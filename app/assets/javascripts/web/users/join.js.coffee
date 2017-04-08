$ ->
  $submit_button = $('.edit_questionary input[type="submit"]')
  $personal_data_checkbox = $('#processing_personal_data')
  $submit_button.prop 'disabled', true
  $personal_data_checkbox.change ->
    $submit_button.prop 'disabled', !$submit_button.prop('disabled')
