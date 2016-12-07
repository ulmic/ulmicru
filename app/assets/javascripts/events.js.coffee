$ ->
  $('#event-lead-more-info').on 'click', ->
    $(this).find('.hide-all').toggleClass 'hide'
    $(this).find('.show-all').toggleClass 'hide'
    $('.more-lead-info').toggleClass 'viewed'
    $('.event-container').toggleClass 'more-info-viewed'

  $ $ask_question = $('.ask-question')
  $ask_question.hide()
  $('#ask-question').on 'click', ->
    if $ask_question.is ':visible'
      $ask_question.slideUp()
    else
      $ask_question.slideDown()


