#= require bounce.js/bounce.min.js

vertical_align = ($element) ->
  parent_height = $element.parents().first().height()
  margin_top =(parent_height - $element.height()) / 2
  $element.css('margin-top', margin_top)

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


  vertical_align $('section#mic_is_content .h3_text')
  vertical_align $('section#mic_is_content .year_text')

  setTimeout (->
    bounce = new Bounce()
    bounce.scale(from: { x: 1, y: 1 },
      to: { x: 2, y: 1 },
      easing: 'bounce',
      duration: 1000,
      delay: 0,
      bounces: 4,
      stiffness: 1
    ).scale(from: { x: 1, y: 1 },
      to: { x: 1, y: 2 },
      easing: 'bounce',
      duration: 1000,
      bounces: 6,
      stiffness: 1
    ).applyTo($('.year_text'))
  ), 1000
