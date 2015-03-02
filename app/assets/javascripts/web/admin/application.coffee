#= require jquery
#= require jquery_ujs
#= require bootstrap-sprockets

$ ->
  $('.link').click ->
    location.href = $(this).attr('data-href')
