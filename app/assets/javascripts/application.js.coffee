# Plugins
#= require jquery
#= require slick
#= require bootstrap-sprockets
#= require jquery_ujs
#= require moment
#= require moment/ru
#= require bootstrap-datetimepicker
#= require pickers
#= require js-routes
#= require active_form
#= require i18n_setup
#= require placeholders
#= require localities
#= require events
#= require news
#= require foundation
#= require select2
#= require web/users/account
#= require jasny-bootstrap
#= require jasny_file_uploader
# Views logic
#= require web/members
#= require web/events
#= require web/welcome
#= require feedback


$ ->
  $(document).foundation()
  #$(document).foundation('tab', 'reflow')

  init_link_class = ->
    $('.link').click ->
      location.href = $(this).data('href')
    $('.tr_link').each ->
      $tr_link = $(this)
      tds = $tr_link.children('td').not('.actions')
      tds.click ->
        location.href = $tr_link.data('href')
    $('.slider-link').click ->
      if $(this).hasClass 'slick-active'
        location.href = $(this).data('href')

  init_select2 = ->
    $('select.select2').select2()

  init_blank_adding = ->
    $('.blank').prop('target', '_blank')

  init_select2()
  init_link_class()
  init_blank_adding()
  return
