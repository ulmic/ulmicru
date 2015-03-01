#= require jquery
#= require bootstrap-sprockets

$ ->
  $('.link').click ->
    location.href = $(this).attr('data-href')
