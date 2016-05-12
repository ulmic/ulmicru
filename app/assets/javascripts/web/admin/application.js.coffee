#= require jquery
#= require bootstrap-sprockets
#= require jquery_ujs
#= require moment
#= require moment/ru
#= require bootstrap-datetimepicker
#= require pickers
#= require active_form
#= require js-routes
#= require i18n_setup
#= require tabs
#= require localities
#= require ckeditor/init
#= require web/admin/popup
#= require web/admin/places
#= require select2
#= require jasny-bootstrap
#= require jasny_file_uploader
#= require placeholders

$.extend String.prototype, camelize: ->
  @replace /(?:^|[-_])(\w)/g, (_, c) ->
    if c then c.toUpperCase() else ''

$ ->
  init_bootstrap_styles = ->
    $('.input').addClass('form-group')
    $('select').addClass('form-control')
    $('input[type=hidden]').addClass('form-control')
    $('input[type=text]').addClass('form-control')
    $('input[type=submit]').addClass('btn')
    $('textarea').addClass('form-control')

  init_select2_inputs = ->
    $('select.select2').each ->
      $(this).select2 {
        placeholder: $(this).data('prompt')
      }
  $('.link').click ->
    location.href = $(this).attr('data-href')

  init_blank_adding = ->
    $('.blank').prop('target', '_blank')

  $('a.btn-xs span.glyphicon').each ->
    color = $(this).parents('.btn-xs').first().attr('class').replace('btn-xs', '').replace('btn ', '').split('-')[1].trim()
    klass = $(this).attr('class').split(' ')[1]
    glyphicon_titles = {
      success: {
        ok: 'approve',
        plus: 'add',
        pushpin: 'main',
        font: 'string',
        user: 'user',
        calendar: 'event',
        flag: 'activity_line',
        bullhorn: 'team'
      }
      warning: {
        pencil: 'edit'
      }
      primary: {
        open: 'restore'
      }
      danger: {
        remove: 'destroy',
        pushpin: 'remain'
      }
      'triangle-bottom': 'actions'
    }
    action = glyphicon_titles[color][klass.replace('glyphicon-', '')]
    $(this).closest('a.btn-xs').prop('title', I18n.t("helpers.links.#{action}"))
    return

  init_datetimepickers = ->
    $("input.datetime_picker").datetimepicker()
    $("input.date_picker").datetimepicker()
    return

  init_dropdown_sub_menu = ->
    $('.dropdown-menu > li > a.trigger').on 'click', (e) ->
      current = $(this).next()
      grandparent = $(this).parent().parent()
      if $(this).hasClass('left-caret') or $(this).hasClass('right-caret')
        $(this).toggleClass 'right-caret left-caret'
      grandparent.find('.left-caret').not(this).toggleClass 'right-caret left-caret'
      grandparent.find('.sub-menu:visible').not(current).hide()
      current.toggle()
      e.stopPropagation()
      return
    $('.dropdown-menu > li > a:not(.trigger)').on 'click', ->
      root = $(this).closest('.dropdown')
      root.find('.left-caret').toggleClass 'right-caret left-caret'
      root.find('.sub-menu:visible').hide()
      return
    return

  init_bootstrap_styles()
  init_select2_inputs()
  init_blank_adding()
  init_datetimepickers()
  init_dropdown_sub_menu()
  $('a.add_fields').click ->
    setTimeout( (->
      init_bootstrap_styles()
      init_select2_inputs()
      ), 300)
    setTimeout init_datetimepickers, 1000
    return
  return
