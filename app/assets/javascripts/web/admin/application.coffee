#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require moment
#= require moment/ru
#= require bootstrap-datetimepicker
#= require pickers
#= require js-routes
#= require i18n_setup
#= require froala_editor.min.js
#= require langs/ru.js

$ ->
  $('.link').click ->
    location.href = $(this).attr('data-href')
$ ->
  $('#news_body').editable
    inlineMode: false

$ -> 
  $('#news_published_at').datetimepicker()
