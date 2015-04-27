$ ->
  $circles = $('.event-circle')

  select_circle = ($circle)  ->
    $circle.animate({ width: '100px', height: '100px', marginTop: '0px' }, 200)
    $circle.css 'background-color', '#ffa911'
    return

  unselect_circle = ($circle) ->
    $circle.css 'width', '20px'
    $circle.css 'height', '20px'
    $circle.css 'margin-top', '40px'
    $circle.css 'background-color', 'black'
    return

  show_info = ($circle) ->
    $circle.after("
      <div class = 'event-year'>
        #{$circle.data('year')}
      </div>")
    offset = $circle.offset()
    $('.event-year').offset left: offset.left + 15, top: offset.top + 30

  hide_all_info = ->
    $('.event-year').remove()

  $circles.hover ->
    $circles.each ->
      unselect_circle $(this)
      hide_all_info()
      return
    select_circle $(this)
    show_info $(this)
    return
