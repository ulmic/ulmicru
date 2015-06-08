$ ->
  $('body').append('<div id = "blackout"></div>')
  box_width = 550

  centerBox = ->
    winWidth = $(window).width()
    winHeight = $(document).height()
    scrollPos = $(window).scrollTop()
    disWidth = (winWidth - box_width) / 2
    disHeight = scrollPos + 150
    $('.popup').css({'width' : box_width+'px', 'left' : disWidth+'px', 'top' : disHeight+'px'})
    $('#blackout').css({'width' : winWidth+'px', 'height' : winHeight+'px'})
    return false

  $('.show_popup').click (e) ->
    e.preventDefault()
    e.stopPropagation()
    scrollPos = $(window).scrollTop()
    popup_id = $(this).data('popupId')
    $(".popup##{popup_id}").show()
    $('#blackout').show()
    $('html').scrollTop(scrollPos)
    scroll_lock()

  $('[class*=popup]').click (e) ->
    e.stopPropagation()

  $('html').click ->
    scrollPos = $(window).scrollTop()
    $(".popup").hide()
    $('#blackout').hide()
    $('html').scrollTop(scrollPos)
    scroll_restore()

  $('.close').click ->
    scrollPos = $(window).scrollTop()
    $('.popup').hide()
    $('#blackout').hide()
    $('html').scrollTop(scrollPos)
    scroll_restore()

  scroll_lock = ->
    $('html, body').css 'overflow', 'hidden'

  scroll_restore = ->
    $('html, body').css 'overflow', 'auto'

  $(window).resize(centerBox)
  $(window).scroll(centerBox)
  centerBox()
