$ ->

  spin = ->
    '<span class = "spin"></span>'

  # News

  $news_slider = $('.news-slider')
  $right_arrow = $('.news .right-arrow')
  options = {
    infinite: false
    slidesToShow: 5
    slidesToScroll: 5
    prevArrow: $('.news .left-arrow')
    nextArrow: $('.news .right-arrow')
  }

  init_slider = ->
    $('.main-slider .slider-items').slick {
      centerMode: true
      autoplay: true
      autoplaySpeed: 6000
      speed: 800
      centerPadding: '22%'
      slidesToShow: 1
      responsive: [
        {
          breakpoint: 1100
          settings: {
            centerPadding: '20%'
          }
        }
      ]
      prevArrow: $('.main-slider .left-arrow')
      nextArrow: $('.main-slider .right-arrow')
    }
    $news_slider.slick options
    $news_slider.on 'afterChange', ->
      $first_active_slide = $('.news-slider .slick-track a.slick-active').first()
      if $first_active_slide.prop('href') == ''
        $('.news-slider .slick-track a').slice(-5).each ->
          $(this).append spin()
        count = 5
        params = {
          count: count
          offset: parseInt($('.news-slider .slick-track a').length) - count
          tag: $right_arrow.data('tag')
        }
        load_news params
    return

  remove_all_slides = ->
    slideIndex = $('.news-slider .slick-track a').length - 1
    while slideIndex >= 0
      $news_slider.slick 'slickRemove', slideIndex--

  text_news_template = ->
    "
      <a class='new-slider-item slick-slide'>
        <p class='date'>
        </p>
        <p class='content title'>
        </p>
        <p class='content text'>
        </p>
      </a>
    "

  append_news = ->
    index = $('.news-slider .slick-track a').last().data('slick-index')
    $news_slider.slick 'slickAdd', text_news_template()

  append_empty_items = ->
    for i in [0..4]
      append_news()

  fill_news = (news) ->
    $news_slider_item = $('.news-slider .slick-track a').slice -5
    $news_slider_item.each ->
      $(this).children('span.spin').remove()
    $news_slider_item.each (index) ->
      current_news = news[index]
      unless current_news == undefined
        $(this).prop 'href', Routes.news_path current_news.id
        $date = $(this).children('p.date').first()
        $title = $(this).children('p.content.title').first()
        $text = $(this).children('p.content.text').first()

        $date.html current_news.publish_date_time
        $title.html current_news.title
        $text.html current_news.text
      return
    return

  load_news = (params) ->
    $.ajax {
      url: Routes.api_news_index_path()
      method: 'GET'
      data: params
      dataType: 'json'
      success: (response) ->
        if params['offset'] == 0
          remove_all_slides()
          append_empty_items()
        fill_news response
        append_empty_items()
      error: ->
        alert 'error'
    }

  add_tag_to_button = (tag_params)  ->
    $right_arrow.data('tag', tag_params)

  get_offset = (tag, count) ->
    slider_tag = $news_slider.data('tag')
    return 0 if tag == undefined
    if slider_tag == tag
      parseInt($('.news-slider .slick-track a').length) - count
    else
      0

  $category_list = $('.category-navbar-container ul li:not(.swap)')

  flag_li = ($li) ->
    $category_list.each ->
      $a = $(this).children('a').first()
      $a.css('color', '')
    if $li.hasClass('departament')
      color = 'black'
    else
      color = '#f45c10'
    if $li.hasClass('all_news')
      colorize_all_news()
    else
      $a = $li.children('a').first()
      $a.css('color', color)

  colorize_all_news = ->
    $('.category-navbar-container ul li.all_news').each ->
      if $(this).hasClass('departament')
        color = 'black'
      else
        color = '#f45c10'
      $a = $(this).children('a').first()
      $a.css('color', color)

  $category_list.click ->
    count = 5
    data_type = $(this).data('type')
    data_tag = $(this).data('tag')
    if data_type == 'string'
      tag_type = 'string'
      text = data_tag
    else
      tag_type = 'link'
      target_type = data_type
      title = data_tag
    if data_tag == undefined
      params = {
        count: count
        offset: get_offset(data_tag, count)
      }
    else
      params = {
        count: count
        offset: get_offset(data_tag, count)
        tag: {
          tag_type: tag_type
          target_type: target_type
          title: title
          text: text
        }
      }
    add_tag_to_button params['tag']
    flag_li $(this)
    $('.news-slider .slick-track a').slice(-5).each ->
      $(this).append spin()
    load_news params

  swap = ($showing, $hiding) ->
    $hiding.slideUp ->
      $hiding.addClass 'hidden'
    $showing.slideDown ->
      $showing.removeClass 'hidden'

  $('li.swap a').click (e) ->
    e.preventDefault()
    $activity_navbar = $('.category-navbar-container nav.top-bar:not(.departaments)')
    $departament_navbar = $('.category-navbar-container nav.top-bar.departaments')
    if $departament_navbar.hasClass 'hidden'
      swap $departament_navbar, $activity_navbar
    else
      swap $activity_navbar, $departament_navbar

  init_slider()
  colorize_all_news()

  # Events

  template_event = (event) ->
    "
      <li class = 'mic-event' style = 'display: none'>
        <a href = '/events/#{event.id}'>
          <img class = 'slider-img' src = '#{event.photo}'/>
        </a>
        <section>
          <span class = 'event-category'>
            #{event.category}
          </span>
          <span>
            #{event.date}
          </span>
        </section>
        <p>
          <a href = '/events/#{event.id}'>
            <b>
              #{event.title}
            </b>
            <br/>
            #{event.text}
          </a>
        </p>
      </li>
    "

  append_events = (events) ->
    $event_list = $('ul#event-list')
    $(events).each ->
      $event_list.append template_event this
    $event_list.children('li').slideDown()

  load_events = ->
    count = 8
    offset = $('li.mic-event').length
    $.ajax {
      url: Routes.api_events_path()
      method: 'GET'
      data: {
        count: count
        offset: offset
      }
      dataType: 'json'
      success: (response) ->
        append_events response.events
        $more_events = $('.more-events')
        $more_events.children('span.spin').remove()
        if response.last_events
          $more_events.remove()
        else
          $more_events.append("<i class = 'fa fa-caret-down fa-5x'></i>")
      error: ->
        alert 'error'
    }

  $('.more-events').click (e) ->
    $(this).append spin()
    $(this).children('.fa-caret-down').remove()
    load_events()
    e.preventDefault()
    return
  return

$(window).on 'load', ->
  stick_to_bottom_of_avatar_labels = ->
    $labels = $('.labels')
    $labels.each ->
      top = $('a.info').first().height() - $(this).height() - 35
      $(this).css 'top', top
  stick_to_bottom_of_avatar_labels()
  return
