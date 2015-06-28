$ ->
  $('form#new_feedback').on('ajax:success', (e, data, status, xhr) ->
    $('#feedback_text').val null
    $('#feedbackModal .close-reveal-modal').trigger 'click'
  ).on('ajax:error', (e, data, status, xhr) ->
    alert 'error'
  )
