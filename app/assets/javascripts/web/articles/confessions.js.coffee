$ ->
  $('.year').hover((->
    $(this).animate({
      marginRight: '+=15'
    }, 500)),
    (->
      $(this).animate({
        marginRight: '-=15'
      }, 500)))
