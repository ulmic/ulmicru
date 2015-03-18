$ ->
  check_locality = ($municipality_input) ->
    return if $municipality_input.attr('id') == undefined
    model_name = $municipality_input.attr('id').split('_')[0]
    $locality_input = $("##{model_name}_locality")
    $locality_input.children('optgroup').prop('disabled', true)
    $locality_input.children("optgroup[label='#{$municipality_input.val()}']").prop('disabled', false)
    return

  init_change_select = ($municipality_input) ->
    $municipality_input.change ->
      check_locality $(this)
      return
    check_locality $municipality_input

  init_change_select $('#member_municipality')
  init_change_select $('#questionary_municipality')
  return
