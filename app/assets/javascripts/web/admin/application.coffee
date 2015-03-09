#= require jquery
#= require jquery_ujs
#= require bootstrap-sprockets
#= require moment
#= require moment/ru
#= require bootstrap-datetimepicker
#= require pickers
#= require froala_editor.min.js

$ ->
  $('.link').click ->
    location.href = $(this).attr('data-href')
$ ->
  $('#news_body').editable
    inlineMode: false

$ -> 
  $('#news_published_at').datetimepicker()
