$ ->
  $join_event_button = $('button.join-button')
  $join_event_button.click ->
    value = $(this).val()
    if value == 'join'
      $.ajax {
        method: 'POST'
        url: Routes.api_events_registrations_path()
        data: {
          event_registration: {
            event_id: $(this).data('eventId')
            user_id: $(this).data('userId')
          }
        }
        success: ->
          $join_event_button.val('out')
          $join_event_button.html('Я участвую')
          return
        error: ->
          #FIXME адекватный алерт
          alert('Произошла ошибка')
          return
      }
    else if value == 'out'
      $.ajax {
        method: 'DELETE'
        url: Routes.api_events_registration_path
        data: {
          event_id: $(this).data('eventId')
          user_id: $(this).data('userId')
        }
        success: ->
          $join_event_button.val('join')
          $join_event_button.html('Участвовать')
          return
        error: ->
          #FIXME адекватный алерт
          alert('Произошла ошибка')
          return
      }
    return
  return
