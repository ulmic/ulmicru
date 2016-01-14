$ ->
  $('form#arguments_form').on('ajax:success', (e, data, status, xhr) ->
    alert I18n.t('javascript.flash.petition_updated')
    $('#argumentsModal .close-reveal-modal').trigger 'click'
    $('.argument_text').val null
  ).on('ajax:error', (e, data, status, xhr) ->
    alert 'error'
  )
  $('.member.petition').on 'click', (e) ->
    e.preventDefault()
    value = $(this).data('id')
    unless $('.confession_id').length == 0
      $('.confession_id').val value
    unless $('.vote').length == 0
      $('.vote').data 'targetId', value
