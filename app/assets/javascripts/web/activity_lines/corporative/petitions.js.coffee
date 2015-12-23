$ ->
  $('form#arguments_form').on('ajax:success', (e, data, status, xhr) ->
    alert I18n.t('javascript.flash.petition_updated')
    $('#argumentsModal .close-reveal-modal').trigger 'click'
    $('.argument_text').val null
  ).on('ajax:error', (e, data, status, xhr) ->
    alert 'error'
  )
  $('.member').on 'click', (e) ->
    e.preventDefault()
    $('.confession_id').val $(this).data('id')
