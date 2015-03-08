#= require jquery
#= require jquery_ujs
#= require bootstrap-sprockets
#= require moment
#= require bootstrap-datetimepicker
#= require pickers

$ ->
  $('.link').click ->
    location.href = $(this).attr('data-href')
