$ ->
  scale_history_text = ->
    $('.history-text').width $('.container-big').width() - $('.history-user-pic-row').width() - 100

  $(window).resize ->
    scale_history_text()
  scale_history_text()
