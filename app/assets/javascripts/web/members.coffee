$ ->
  $view_button = $('#view_all')
  $hide_button = $('#hide_all')
  $god_fathers_childs = $('.god-fathers-childs')

  $view_button.click (e) ->
    e.preventDefault()
    $god_fathers_childs.height('auto')
    $('.godchilds.added.hidden').each ->
      $(this).slideDown()
      $(this).removeClass 'hidden'
    $(this).hide()
    $hide_button.show()

  $hide_button.click (e) ->
    e.preventDefault()
    $('.godchilds.added').each ->
      $(this).slideUp()
      $(this).addClass 'hidden'
    $god_fathers_childs.height('250px')
    $(this).hide()
    $view_button.show()
