# FIXME refactoring
$ ->
  $('.tag_target_id').hide()
  $('.select.tag_text').hide()
  $('.form-group.tag_text input').change ->
    $('.form-group.tag_text select').val $(this).val()

  push_list_to_select_input = (list) ->
    $select_input = $('select#tag_target_id')
    $string_tags_select_input = $('select#tag_text')
    $select_input.empty()
    $string_tags_select_input.empty()
    $list = $(JSON.parse(list.list))
    if list.model == 'Member'
      $list.each ->
        $select_input.append("<option value = #{this.id}>#{this.ticket} | #{this.first_name} #{this.last_name}</option>")
    else if list.model == 'Event' or list.model == 'ActivityLine' or list.model == 'Team'
      $list.each ->
        $select_input.append("<option value = #{this.id}>#{this.title}</option>")
    else if list.model == 'Tag'
      $list.each ->
        $string_tags_select_input.append("<option value = #{this.text}>#{this.text}</option>")

  prepare_select_input = (targetType) ->
    url = ''
    url = Routes.api_admin_members_path() if targetType == 'Member'
    url = Routes.api_admin_activity_lines_path() if targetType == 'ActivityLine'
    url = Routes.api_admin_teams_path() if targetType == 'Team'
    url = Routes.api_admin_events_path() if targetType == 'Event'
    url = Routes.api_admin_tags_path() if targetType == 'Tag'
    $('.loading').show()
    $.ajax {
      url: url
      dataType: 'JSON'
      method: 'GET'
      success: (response) ->
        $('.loading').hide()
        push_list_to_select_input response
        return false
      error: ->
        $('.loading').append('Error')
        $('.loading').fadeOut(5000)
        return false
    }
    return

  show_form = ($form_input) ->
    $form_input.show()
    $form_input.parents('form').children('input[type=submit]').show()

  hide_form = ($form_input) ->
    if !$form_input.hasClass 'tag_text'
      $form_input.show()
      $form_input.hide()
      $form_input.children('select').hide()
    else
      $form_input.hide()
      $form_input.closest('form').children('.form-group.tag_text').children('input[type=text]').addClass('hidden')
      $form_input.closest('form').children('#add_new_string_tag').html I18n.t('web.admin.tags.form.add_new_string_tag')
    $form_input.parents('form').children('input[type=submit]').hide()

  $('#add_new_string_tag').click (e) ->
    e.preventDefault()
    $input = $(this).closest('form').children('.form-group.tag_text').children('input')
    $select =$input.closest('form').children('.select.tag_text')
    if $input.prop('type') == 'hidden'
      $(this).html I18n.t('helpers.cancel')
      $select.hide()
      $select.children('select').prop('disabled', true)
      $input.parents('.form-group.tag_text').removeClass('hidden')
      $input.removeClass('hidden')
      $input.prop('type', 'text')
    else
      $(this).html I18n.t('web.admin.tags.form.add_new_string_tag')
      $select.show()
      $select.children('select').prop('disabled', false)
      $input.addClass('hidden')
      $input.prop('type', 'hidden')

  $('.tag-buttons').children('a.btn.btn-xs').each ->
    $(this).click (e) ->
      e.preventDefault()
      tagType = $(this).data('tagType')
      targetType = $(this).data('targetType')
      $('input#tag_tag_type').val tagType
      $('input#tag_target_type').val targetType
      $tag_text_form_input = $(this).parents('td').first().children('form').first().children('.select.form-group.tag_text')
      $target_form_input = $(this).parents('td').first().children('form').first().children('.form-group.tag_target_id')
      if tagType == 'string'
        if $tag_text_form_input.css('display') == 'none'
          hide_form $target_form_input
          show_form $tag_text_form_input
          prepare_select_input 'Tag'
          $tag_text_form_input.closest('form').children('#add_new_string_tag').show()
        else
          hide_form $tag_text_form_input
          $tag_text_form_input.closest('form').children('#add_new_string_tag').hide()
      else
        if $target_form_input.css('display') == 'none'
          $target_form_input.closest('form').children('#add_new_string_tag').hide()
          hide_form $tag_text_form_input
          show_form $target_form_input
          prepare_select_input targetType
        else
          $target_type_select_input = $('form .form-group select')
          if $target_type_select_input.val() == targetType
            hide_form $target_form_input
          else
            $target_type_select_input.val targetType
            prepare_select_input targetType

  create_li = (title, tag_id) ->
    "<li class = 'list-group-item'>#{title}<a class = 'badge tag_destroy' data-remote = 'true' rel = 'nofollow' data-method = 'delete' href = '/api/admin/tags/#{tag_id}'><span сlass = 'glyphicon glyphicon-remove'>X</span></a></li>"

  $('.tag_form').on('ajax:success', (e, data, status, xhr) ->
    li = ''
    if data.target_type == 'Member'
      li = create_li "#{data.target.ticket} | #{data.target.first_name} #{data.target.last_name}", data.tag_id
    else if data.target_type == 'Event' or data.target_type == 'ActivityLine' or data.target_type == 'Team'
      li = create_li data.target.title, data.tag_id
    else if data.target_type == 'Tag'
      li = create_li data.text, data.tag_id
    $(this).closest('td').children('ul.list-group').append(li)
    tag_destroy_ajax()
    return
  ).on 'ajax:error', (e, xhr, status, error) ->
    alert 'error'
    return

  tag_destroy_ajax = ->
    $('.tag_destroy').on('ajax:success', (e, data, status, xhr) ->
      $(this).closest('li').remove()
      return
    ).on 'ajax:error', (e, xhr, status, error) ->
      alert 'error'
      return
    return

  init_select2_in_tags = ->
    unless $('.select2-tags').length == 0
      $select2_drop = $('.select2-drop')
      $select2_drop.addClass 'tags'

  tag_destroy_ajax()
  $('body').on 'DOMNodeInserted', '.select2-drop', ->
    init_select2_in_tags()
