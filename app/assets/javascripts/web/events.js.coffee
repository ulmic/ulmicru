$ ->
  $participants_count_span = $('span#participants_count')
  $participants_list = $('ul.participants')

  participant_member_template = (participant, avatar_url, role) ->
    "<li class='participant mic-member' id = 'participant_#{participant.id}'>
       <a href='#{Routes.member_path(participant.ticket)}'>
         <img src='#{avatar_url}'>
       </a>
       <section>
         <a href='#{Routes.member_path(participant.ticket)}'>
           <div class='name'>
             #{participant.first_name} #{participant.last_name}
           </div>
           <div class='role'>
             #{I18n.t("enumerize.event.registration.role.#{role}")}
           </div>
         </a>
       </section>
     </li>"

  participant_user_template = (participant, role) ->
    "<li class='participant mic-member' id = 'participant_#{participant.id}'>
       <img src='/default-man-icon.png'>
       <section>
         <div class='name'>
           #{participant.first_name} #{participant.last_name}
         </div>
         <div class='role'>
           #{I18n.t("enumerize.event.registration.role.#{role}")}
         </div>
       </section>
     </li>"

  set_participants_count_from_span = (changes)  ->
    count = parseInt $participants_count_span.html().match(/[0-9]/)[0]
    count += changes
    $participants_count_span.html("(#{count})")

  increase_participant_count = ->
    set_participants_count_from_span 1

  decrease_participant_count = ->
    set_participants_count_from_span -1

  add_event_participant = (response) ->
    participant = JSON.parse response.participant
    role = response.role
    avatar_url = response.avatar_url
    if participant.ticket == null
      $participants_list.prepend participant_user_template participant, role
    else
      $participants_list.prepend participant_member_template participant, avatar_url, role
    increase_participant_count()

  remove_event_participant = (response) ->
    participant_id = response
    $participants_list.children("li#participant_#{participant_id}").remove()
    decrease_participant_count()

  $join_event_button = $('button.join-button')
  $join_event_button.click ->
    value = $(this).val()
    if value == 'join'
      $.ajax {
        method: 'POST'
        url: Routes.api_events_registrations_path()
        dataType: 'JSON'
        data: {
          event_registration: {
            event_id: $(this).data('eventId')
            user_id: $(this).data('userId')
          }
        }
        success: (response) ->
          $join_event_button.val('out')
          $join_event_button.html I18n.t('web.events.show.i_attend')
          add_event_participant(response)
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
        dataType: 'JSON'
        data: {
          event_id: $(this).data('eventId')
          user_id: $(this).data('userId')
        }
        success: (response) ->
          $join_event_button.val('join')
          $join_event_button.html I18n.t('web.events.show.attend')
          remove_event_participant response
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
      $list_other_participants.slideDown()
      $show_other_participants.html I18n.t('web.events.show.hide')
    else
      $list_other_participants.slideUp()
      $show_other_participants.html I18n.t('web.events.show.see_more')
  return

