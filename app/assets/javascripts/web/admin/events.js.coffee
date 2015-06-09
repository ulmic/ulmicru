$ ->
  $event_place_select = $('select#event_place')
  open = (elem) ->
    if document.createEvent
      e = document.createEvent('MouseEvents')
      e.initMouseEvent 'mousedown', true, true, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null
      elem[0].dispatchEvent e
    else if element.fireEvent
      elem[0].fireEvent 'onmousedown'
      return

  init_4sq_place_select = ->
    $event_place_select.hide()
    $('#update_list').click (e) ->
      e.preventDefault()
      place = $('input[type=text]#place_').val()
      unless place == ''
        $('.loading').show()
        $.ajax {
          method: 'GET'
          url: Routes.index_api_admin_places_path(place)
          dataType: 'JSON'
          success: (response) ->
            $event_place_select.show()
            $event_place_select.empty()
            $(response).each ->
              if this.city != null
                $event_place_select.append("<option value = #{this.id}>#{this.name} | #{this.city}</option>")
              else
                $event_place_select.append("<option value = #{this.id}>#{this.name}</option>")
            $('.loading').hide()
            open $event_place_select
            $event_place_select.focus()
            $('.event_place.hidden').remove()
            return false
          error: (response) ->
            $('.loading').append('Error')
            $('.loading').fadeOut(5000)
            return false
        }
    return

  enable_organizer_opt_group = ($select, $organizer_select) ->
    $organizer_select.children('optgroup').prop('disabled', true)
    $organizer_select.children("optgroup[label='#{$select.children('option:selected').text()}']").prop('disabled', false)

  init_event_organizer_select = ->
    $event_organizer_select = $('select#event_organizer')
    $event_organizer_type_select = $('select#event_organizer_type')
    $event_organizer_select.children('optgroup').prop('disabled', true)
    $event_organizer_type_select.change ->
      enable_organizer_opt_group $(this), $event_organizer_select
    enable_organizer_opt_group $event_organizer_type_select, $event_organizer_select
    return

  init_4sq_place_select()
  init_event_organizer_select()
  return
