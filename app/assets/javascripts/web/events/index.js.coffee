$ ->
  spin = ->
    '<span class = "spin"></span>'
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
