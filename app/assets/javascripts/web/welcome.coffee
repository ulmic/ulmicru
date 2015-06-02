$ ->
  $news_slider = $('.news-slider')
  options = {
    infinite: false
    slidesToShow: 5
    slidesToScroll: 5
    prevArrow: $('.news .slider-arrows>.left-arrow')
    nextArrow: $('.news .slider-arrows>.right-arrow')
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
    return

  text_news_template = ->
    "
      <a class='new-slider-item slick-slide' href='/news/33'>
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
    $news_slider_item.each (index) ->
      current_news = news[index]
      $(this).prop 'href', Routes.news_path current_news.id
      $date = $(this).children('p.date').first()
      $title = $(this).children('p.content.title').first()
      $text = $(this).children('p.content.text').first()

      $date.html current_news.publish_date_time
      $title.html current_news.title
      $text.html current_news.text
      return
    return

  load_news = ->
    count = 5
    offset = parseInt($('.news-slider .slick-track a').length) - count
    $.ajax {
      url: Routes.api_news_index_path(),
      method: 'GET'
      data: {
        count: count
        offset: offset
      }
      dataType: 'json'
      success: (response) ->
        fill_news response
        append_empty_items()
      error: ->
        alert 'error'
    }

  $left_arrow = $('.news a.arrow.left-arrow')
  $right_arrow = $('.news a.arrow.right-arrow')

  load = ->
    num = parseInt $right_arrow.data('load')

  crease = ->
    parseInt $left_arrow.data('crease')

  $left_arrow.click ->
    if crease() > 0
      $right_arrow.data('load', load() + 1)
      $left_arrow.data('crease', crease() - 1)
    return

  $right_arrow.click ->
    if load() == 0
      $left_arrow.data('crease', crease() + 1)
      load_news()
    else
      $right_arrow.data('load', load() - 1)
    return

  init_slider()
  return
