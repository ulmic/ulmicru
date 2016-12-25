$ ->
  $('.youtube_video iframe').each ->
    padding_left = $(this).parents().parents().css('padding-left').replace('px', '')
    padding_right = $(this).parents().parents().css('padding-right').replace('px', '')
    width = $(this).parents().parents().width()
    width_100_percent = width - padding_left - padding_right
    $(this).prop 'width', width_100_percent
    $(this).prop 'height', width_100_percent / 16 * 9
