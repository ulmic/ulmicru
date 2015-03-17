#= require jquery-ui/tabs

$ ->
  $('#tabs').tabs()
  $('#tabs ul li').first().addClass 'active'
  $('#tabs ul li').click ->
    $('#tabs ul li').removeClass 'active'
    $(this).addClass 'active'
  return
