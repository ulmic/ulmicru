$ ->
  $('.member').on 'click', (e) ->
    e.preventDefault()
    $('.confession_id').val $(this).data('id')
