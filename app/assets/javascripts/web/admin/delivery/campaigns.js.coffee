$ ->
  $audience_form = $('#new_delivery_audience')
  $audience_form.hide()
  $('.add-audience').click ->
    if $audience_form.css('display') == 'block'
      $audience_form.slideUp()
    else
      $audience_form.slideDown()
