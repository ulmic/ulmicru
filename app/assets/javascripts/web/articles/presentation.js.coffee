$ ->
  $('.main-navbar-container').hide()
  $('.footer').hide()
  $('.full-page-logo').hide()
  $('.theme-button').hide()
  $('.theme-button').each ->
    $(this).height $(this).width()
    $(this).mouseenter ->
      $(this).children('.title').slideDown 300
    $(this).mouseout ->
      $(this).children('.title').slideUp 200

  setTimeout (->
    $('.full-page-logo').fadeIn(1500, (->
      $('.theme-button').each (index) ->
        $this = $(this)
        setTimeout (->
          $this.fadeIn()
        ), index * 300
    ))
  ), 500

