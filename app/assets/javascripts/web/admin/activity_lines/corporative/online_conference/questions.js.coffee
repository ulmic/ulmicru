$ ->
  $submit_button = $('form.edit_activity_lines_corporative_online_conference_question input[type=submit]')
  $submit_button.prop 'disabled', true
  $('#activity_lines_corporative_online_conference_question_answer_timestamp').on 'input', ->
    $submit_button.prop 'disabled', !$(this).val().match(/\d+:\d+/)
