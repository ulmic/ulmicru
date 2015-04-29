$ ->
  scale_history_text = ->
    $('.history-text').width $('.container-big').width() - $('.history-user-pic-row').width() - 120
    return

  $(window).resize ->
    scale_history_text()
    return
  return
