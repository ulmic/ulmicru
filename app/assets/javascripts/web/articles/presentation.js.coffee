$ ->
  $('.main-navbar-container').hide()
  $('.footer').hide()
  $('.full-page-logo').hide()
  $('.theme-button').each ->
    $(this).height $(this).width()
    #$(this).mouseover ->
    #  $('.theme-button .title').fadeDown()

  setInterval (->
    $('.full-page-logo').fadeIn(1500)
  ), 500

