#= require jquery

$ ->
  init_slidebar = ($element) ->
    $element.click ->
      states = {
        opened: '510px'
        closed: '10px'
      }
      text_states = {
        opened: '0px'
        closed: '-500px'
      }
      $sidebar_button = $('.sidebar_button')
      $text = $('.text')
      left = $sidebar_button.css('left')
      if left == states['opened']
        $sidebar_button.animate { left: states['closed'] }, 1000
        $text.animate { left: text_states['closed'] }, 1000
        $('.blackout').hide()
      else
        $sidebar_button.animate { left: states['opened'] }, 1000
        $text.animate { left: text_states['opened'] }, 1000
        $('.blackout').show()

  init_slidebar $('.sidebar_button')
  init_slidebar $('.blackout')
