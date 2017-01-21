$ ->
  $('form#new_place').on 'ajax:success', ->
    $('#placeForm').modal('hide')
  $('form#new_place').on 'ajax:error', ->
    alert 'error'
  list_option = (value, label) ->
    "<option value = #{value}>#{label}</option>"

  enable_organizer_opt_group = ($select, $organizer_select, event) ->
    selected_organizer_type = $select.children('option:selected').val().toLowerCase()
    collection = $organizer_select.data 'collection'
    organizers = collection[selected_organizer_type + 's']
    $organizer_select.empty()
    $(organizers).each ->
      $organizer_select.append list_option this[0], this[1]
      return
    if event == 'init'
      value = $organizer_select.data 'selectedId'
      $organizer_select.val(value).trigger 'change'
    else if event == 'change'
      $organizer_select.val(null).trigger 'change'
    return

  init_event_organizer_select = ->
    $event_organizer_select = $('select#event_organizer_id')
    $event_organizer_type_select = $('select#event_organizer_type')
    $event_organizer_type_select.change ->
      enable_organizer_opt_group $(this), $event_organizer_select, 'change'
    enable_organizer_opt_group $event_organizer_type_select, $event_organizer_select, 'init'
    return

  init_event_organizer_select()
  return
