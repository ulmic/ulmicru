$ ->
  $('.main-navbar-container').hide()
  $('.footer').hide()
  $('.full-page-logo').hide()

  setInterval (->
    $('.full-page-logo').fadeIn(1500)
  ), 500
