$ ->
  $municipality_input = $('.municipality_input')
  $municipality_input.hide()

  show_or_hide_municipality_input = ($element) ->
    if $element.val() == 'Team::Departament'
      $municipality_input.show()
    else if $element.val() != undefined
      $municipality_input.hide()
    return

  init_municipality_input = ($input) ->
    unless $input == undefined
      $input.change ->
        show_or_hide_municipality_input $input
        return
      show_or_hide_municipality_input $input
    return

  init_municipality_input $('.team_departament_type select')
  init_municipality_input $('.team_type select')
  init_municipality_input $('.team_subdivision_type select')
  init_municipality_input $('.team_administration_type select')
  return
