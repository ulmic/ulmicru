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
#= require web/admin/tags
#= require web/admin/popup
#= require web/admin/places
#= require select2
#= require jasny-bootstrap
#= require jasny_file_uploader
#= require placeholders

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
    $('select.select2-tags').each ->
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

  init_bootstrap_styles()
  init_select2_inputs()
  init_blank_adding()
  init_datetimepickers()
  $('a.add_fields').mouseover ->
    init_bootstrap_styles()
    init_select2_inputs()
    setTimeout init_datetimepickers, 500
    return

  return
