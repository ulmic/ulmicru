$ ->
  $municipality_input = $('.municipality_input')
  $municipality_input.hide()

  $school_input = $('.school_input')
  $school_input.hide()

  $title_input = $('.title_input')
  $title_input.hide()

  $team_input = $('.team_input')
  $team_input.hide()

  show_or_hide_municipality_input = ($element) ->
    if $element.val() in ['Team::Departament', 'Team::Primary']
      $municipality_input.slideDown()
    else if $element.val() != undefined
      $municipality_input.slideUp()
    return

  show_or_hide_school_input = ($element) ->
    if $element.val() == 'Team::Primary'
      $school_input.slideDown()
    else if $element.val() != undefined
      $school_input.slideUp()
    return

  show_or_hide_title_input = ($element) ->
    if $element.val() in ['Team::Administration', 'Team::Subdivision']
      $title_input.slideDown()
    else if $element.val() != undefined
      $title_input.slideUp()
    return

  show_or_hide_team_input = ($element) ->
    if $element.val() == 'Team::Primary'
      $team_input.slideDown()
    else if $element.val() != undefined
      $team_input.slideUp()

  init_hidden_inputs = ($input) ->
    unless $input == undefined
      $input.change ->
        show_or_hide_municipality_input $input
        show_or_hide_school_input $input
        show_or_hide_title_input $input
        show_or_hide_team_input $input
        return
      show_or_hide_municipality_input $input
      show_or_hide_school_input $input
      show_or_hide_title_input $input
      show_or_hide_team_input $input
    return

  init_hidden_inputs $('.team_departament_type select')
  init_hidden_inputs $('.team_type select')
  init_hidden_inputs $('.team_subdivision_type select')
  init_hidden_inputs $('.team_administration_type select')
  init_hidden_inputs $('.team_primary_type select')
  return
