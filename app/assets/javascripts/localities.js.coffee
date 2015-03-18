$ ->
  check_locality = ($municipality_input) ->
    $locality_input = $('#member_locality')
    $locality_input.children('optgroup').prop('disabled', true)
    $locality_input.children("optgroup[label='#{$municipality_input.val()}']").prop('disabled', false)
    return

  $('#member_municipality').change ->
    check_locality $(this)
    return

  check_locality $('#member_municipality')
  return
