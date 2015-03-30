$ ->
  open = (elem) ->
    if document.createEvent
      e = document.createEvent('MouseEvents')
      e.initMouseEvent 'mousedown', true, true, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null
      elem[0].dispatchEvent e
    else if element.fireEvent
      elem[0].fireEvent 'onmousedown'
      return

  $('#update_list').click (e) ->
    e.preventDefault()
    place = $('input[type=text]#place_').val()
    unless place == ''
      $('.loading').show()
      $event_place_select = $('select#event_place')
      $.ajax {
        method: 'GET'
        url: Routes.index_api_admin_places_path(place)
        dataType: 'JSON'
        success: (response) ->
          $event_place_select.empty()
          $(response).each ->
            if this.city != null
              $event_place_select.append("<option value = #{this.id}>#{this.name} | #{this.city}</option>")
            else
              $event_place_select.append("<option value = #{this.id}>#{this.name}</option>")
          $('.loading').hide()
          open $event_place_select
          $event_place_select.focus()
          return false
        error: (response) ->
          $('.loading').append('Error')
          $('.loading').fadeOut(5000)
          return false
      }
