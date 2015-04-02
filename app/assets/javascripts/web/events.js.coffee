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
          $join_event_button.html I18n.t('web.events.show.i_attend')
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
          $join_event_button.html I18n.t('web.events.show.attend')
          return
        error: ->
          #FIXME адекватный алерт
          alert('Произошла ошибка')
          return
      }
    return
  $show_other_participants = $('button#show_other_participants')
  $show_other_participants.click ->
    $list_other_participants = $('ul.small-block-grid-5.participants.other')
    if $list_other_participants.css('display') == 'none'
      $list_other_participants.show()
      $show_other_participants.html I18n.t('web.events.show.hide')
    else
      $list_other_participants.hide()
      $show_other_participants.html I18n.t('web.events.show.see_more')
  return

