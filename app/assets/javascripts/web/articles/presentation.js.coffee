$ ->
  $('.main-navbar-container').hide()
  $('.footer').hide()
  $('.full-page-logo').hide()
  $('.theme-button').each ->
    $(this).height $(this).width()

  setInterval (->
    $('.full-page-logo').fadeIn(1500)
  ), 500
