$ ->
  $submit_button = $('form.new_places_place input[type=submit]')

  fill_coordinates_input = (response)  ->
    coordinates = response.response.GeoObjectCollection.featureMember[0].GeoObject.boundedBy.Envelope.upperCorner
    $('#places_place_ll').val coordinates.replace(' ', ',')
    $submit_button.show()

  $('.see_coordinates').click (e) ->
    e.preventDefault()
    url = "http://geocode-maps.yandex.ru/1.x/?geocode=#{$('#places_place_state').val()}+#{$('#places_place_city').val()}+#{$('#places_place_address').val()}&format=json"
    $.ajax {
      url: url
      dataType: 'json'
      success: (response) ->
        fill_coordinates_input response
        return
      error: ->
        alert 'error'
        return
    }
    return
  $('#new_places_place').on('ajax:success', (e, data, status, xhr) ->
    $('.popup#place_form .close').trigger 'click'
    $('select#event_place').html("<option value = '#{data.id}'>#{data.name}</option>")
    $('select#event_place').val data.id
  ).on('ajax:error', (e, data, status, xhr) ->
    alert 'error'
  )

  init_place_form = ->
    $submit_button.hide()
    $locality_select = $('.grouped_select.places_place_city')
    $locality_select.hide()
    $('#places_place_state').change ->
      if $(this).val() == 'Ульяновская область'
        $locality_select.slideDown()
      else
        $locality_select.slideUp()
      return
    $('#places_place_ll').change ->
      if $(this).val() == ''
        $submit_button.show()
      else
        $submit_button.hide()
      return
    return

  init_place_form()
