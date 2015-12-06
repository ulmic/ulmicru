$ ->
  $('.year').hover((->
    $(this).animate({
      marginRight: '+=15'
    }, 500)),
    (->
      $(this).animate({
        marginRight: '-=15'
      }, 500)))
  $('.year').click ->
    id = $(this).data 'element'
    $('html, body').animate({
      scrollTop: $(id).offset().top - 20
    }, 2000)
