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
$(window).load ->
  confessions_height = 0
  $('.confessions_people').each ->
    confessions_height += $(this).height()
  confessions_height += 15
  $('.confessions').css height: confessions_height
  nomination_name_width = $('.member').width()
  $('.debut_name').width nomination_name_width
  $('.number_one_name').width nomination_name_width
