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
#= require react_integration
#= require youtube_embed_responsive
# Views logic
#= require web/members
#= require web/events
#= require web/welcome
#= require web/news
#= require feedback

window.vertical_align = ($element) ->
  parent_height = $element.parents().first().height()
  margin_top =(parent_height - $element.height()) / 2
  $element.css('margin-top', margin_top)


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

  init_tabs = ->
    $('ul.tabs').children('li').first().addClass 'active'
    $('.tabs-content').children('.content').first().addClass 'active'

  init_datetimepickers = ->
    $('.datepicker').datetimepicker()

  init_eye_password_button = ->
    $('a.eye').click (e) ->
      e.preventDefault()
      $password_input = $(@).parents('.row-fluid').first().children().children('.password_foundation').first()
      if $password_input.prop('type') == 'password'
        $password_input.prop('type', 'text')
      else
        $password_input.prop('type', 'password')

  init_clicks_recording = ->
    $('a.record').click ->
      id = $(this).attr('id')
      className = "#{$(this).attr('class').replace(/ /g, '.')}"
      if id == undefined
        selector = className
      else
        selector = "#{className}##{id}"
      href = $(this).attr('href')
      $.ajax {
        url: Routes.api_clicks_path()
        method: 'POST'
        data: {
          click: {
            html_id: selector
            url: href
            page_url: window.location.href
          }
        }
      }

  $('a').addClass 'record'

  init_select2()
  init_link_class()
  init_blank_adding()
  init_tabs()
  init_eye_password_button()
  init_clicks_recording()

  $('a.add_fields').click ->
    setTimeout init_datetimepickers, 500
    setTimeout init_select2, 500

  # FIXME WHY!! ERROR!!!
  $('.footer .footer-newsletter form').on 'submit', (e) ->
    e.preventDefault()
    $input = $(this).children('input')
    $input.prop 'disabled', 'disabled'
    $.ajax {
      url: Routes.api_delivery_contact_emails_path()
      method: 'POST'
      data: {
        delivery_contact_email: {
          email: $('.footer .footer-newsletter form input[type="email"]').val()
        }
      }
      success: ->
        $input.prop 'disabled', ''
        $('.footer .footer-newsletter form').slideUp()
        $('#success_subscribed').slideDown()
      error: ->
        alert I18n.t('layouts.web.shared.footer.there_an_error')
        $input.prop 'disabled', ''
    }
  return
  
