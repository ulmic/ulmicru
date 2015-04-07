#FIXME refactoring
$ ->
  $('.tag_target_id').hide()

  show_form = ($form_input) ->
    if $form_input.hasClass 'select'
      $form_input.show()
      $form_input.children('select').show()
    else
      $form_input.removeClass('hidden')
      $form_input.children().removeClass('hidden')
      $form_input.children('input').prop('type', 'text')
    $form_input.parents('form').children('input[type=submit]').show()

  hide_form = ($form_input) ->
    if $form_input.hasClass 'select'
      $form_input.show()
      $form_input.hide()
      $form_input.children('select').hide()
    else
      $form_input.addClass('hidden')
      $form_input.children().addClass('hidden')
      $form_input.children('input').prop('type', 'hidden')
    $form_input.parents('form').children('input[type=submit]').hide()

  is_list_of_members = (list) ->
    list[0].ticket != undefined

  push_list_to_select_input = (list) ->
    $select_input = $('select#tag_target_id')
    $select_input.empty()
    if is_list_of_members list
      $(list).each ->
        $select_input.append("<option value = #{this.id}>#{this.ticket} | #{this.first_name} #{this.last_name}</option>")

  prepare_select_input = (targetType) ->
    if targetType == 'Member'
      $('.loading').show()
      $.ajax {
        url: Routes.api_admin_members_path()
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

  $('.tag-buttons').children('a.btn.btn-xs').each ->
    $(this).click (e) ->
      e.preventDefault()
      tagType = $(this).data('tagType')
      targetType = $(this).data('targetType')
      $('input#tag_tag_type').val tagType
      $('input#tag_target_type').val targetType
      $tag_text_form_input = $(this).parents('td').first().children('form').first().children('.form-group.tag_text')
      $target_form_input = $(this).parents('td').first().children('form').first().children('.form-group.tag_target_id')
      if tagType == 'string'
        if $tag_text_form_input.hasClass 'hidden'
          hide_form $target_form_input
          show_form $tag_text_form_input
        else
          hide_form $tag_text_form_input
      else
        if $target_form_input.css('display') == 'none'
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

  $('#new_tag').on('ajax:success', (e, data, status, xhr) ->
    $(this).closest('td').children('ul.list-group').append("<li class = 'list-group-item'>#{data[0].ticket} | #{data[0].first_name} #{data[0].last_name}<a class = 'badge tag_destroy' data-remote = 'true' rel = 'nofollow' data-method = 'delete' href = '/api/admin/tags/#{data[1]}'><span сlass = 'glyphicon glyphicon-remove'>X</span></a></li>")
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

  tag_destroy_ajax()
