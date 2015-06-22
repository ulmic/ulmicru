$ ->
  $('form#new_feedback').on('ajax:success', (e, data, status, xhr) ->
    $('#feedbackModal .close-reveal-modal').trigger 'click'
  ).on('ajax:error', (e, data, status, xhr) ->
    alert 'error'
  )
