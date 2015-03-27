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
#= require spin.min

$ ->
  $('.link').click ->
    location.href = $(this).attr('data-href')

  $('a.btn-xs span.glyphicon').each ->
    klass = $(this).attr('class').split(' ')[1]
    glyphicon_titles = {
      pencil: 'edit',
      remove: 'destroy',
      ok: 'approve',
      plus: 'add',
      open: 'restore',
      'triangle-bottom': 'actions'
    }
    action = glyphicon_titles[klass.replace('glyphicon-', '')]
    $(this).closest('a.btn-xs').prop('title', I18n.t("helpers.links.#{action}"))
    return
  return

  init_datetimepickers = ->
    $("input.datetime_picker").datetimepicker()
    $("input.date_picker").datetimepicker()

  init_datetimepickers()
  $('a.add_fields').mouseover ->
    setTimeout init_datetimepickers, 500
    return
  return
