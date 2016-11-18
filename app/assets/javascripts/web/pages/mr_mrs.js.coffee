#= require jquery
set_background_color = (color) ->
  $('body').css('background-color', color)
  $('#content').css('background-color', color)
  $('.container').css('background-color', color)

get_view = (hash) ->
  colors = {
    '#view_1': '#f0eff4',
    '#view_2': '#232323',
    '#view_3': '#edcfdb'
    '#view_4': '#496e9b'
  }
  set_background_color colors[hash]
  if hash == '#view_2'
    $('h3').css('color', '#f0eff4')
    $('.text').removeClass('small-6').addClass('small-4')
    $('.image').removeClass('small-6').addClass('small-8')
  if hash == '#view_4'
    $('h3').css('color', 'white')
  return

$ ->
  get_view "##{$('.row.mr_mrs').prop('id')}"
