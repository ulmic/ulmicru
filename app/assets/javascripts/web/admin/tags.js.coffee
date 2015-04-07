#FIXME refactoring
$ ->
  $('.tag_target').hide()

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

  prepare_select_input = (targetType) ->
    if targetType == 'member'
      $('.loading').show()
      $.ajax {
        url: Routes.api_admin_members_path()
        dataType: 'JSON'
        method: 'GET'
        success: (response) ->
          $('.loading').hide()
          #list_to_select_input response
          return false
        error: ->
          $('.loading').append('Error')
          $('.loading').fadeOut(5000)
          return false
      }

  $('.tag-buttons').children('a.btn.btn-xs').each ->
    $(this).click (e) ->
      e.preventDefault()
      tagType = $(this).data('tagType')
      targetType = $(this).data('targetType')
      $('select#tag_tag_type').val tagType
      $('select#tag_target_type').val targetType
      $tag_text_form_input = $(this).parents('td').first().children('form').first().children('.form-group.tag_text')
      $target_form_input = $(this).parents('td').first().children('form').first().children('.form-group.tag_target')
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
