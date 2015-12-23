$ ->
  $('.member').on 'click', (e) ->
    e.preventDefault()
    $('body').append $(vote_popover_template())
