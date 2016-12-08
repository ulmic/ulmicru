$ ->
  $('.main-navbar-container').hide()
  $('.footer').hide()
  $('.full-page-logo').hide()
  $('.theme-button').each ->
    $(this).height $(this).width()
    $(this).mouseover ->
      $(this).children('.title').slideDown()
    $(this).mouseout ->
      $(this).children('.title').slideUp()

  setInterval (->
    $('.full-page-logo').fadeIn(1500)
  ), 500

