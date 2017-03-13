$ ->
  $('#event-lead-more-info').on 'click', (e) ->
    e.preventDefault()
    if $('.more-lead-info').is(':visible')
      $('.more-lead-info').slideUp()
    else
      $('.more-lead-info').slideDown()
    $('.event-container').toggleClass 'more-info-viewed'

  $ $ask_question = $('.ask-question')
  $ask_question.hide()
  $('#ask-question').on 'click', ->
    if $ask_question.is ':visible'
      $ask_question.slideUp()
    else
      $ask_question.slideDown()


