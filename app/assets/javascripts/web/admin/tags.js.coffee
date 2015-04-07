$ ->
  $('.tag-buttons').children('a.btn.btn-xs').each ->
    $(this).click (e) ->
      e.preventDefault()
      tagType = $(this).data('tagType')
      targetType = $(this).data('targetType')
      $('select#tag_tag_type').val tagType
      $('select#tag_target_type').val $(this).data('targetType')
      if tagType == 'string'
        $form_input = $(this).parents('td').first().children('form').first().children('.form-group.tag_text')
        if $form_input.hasClass 'hidden'
          $form_input.removeClass('hidden')
          $form_input.children().removeClass('hidden')
          $form_input.children('input').prop('type', 'text')
        else
          $form_input.addClass('hidden')
          $form_input.children().addClass('hidden')
          $form_input.children('input').prop('type', 'hidden')
      else
        $form_input = $(this).parents('td').first().children('form').first().children('.form-group.tag_target')
        if $form_input.hasClass 'hidden'
          $form_input.removeClass('hidden')
          $form_input.children().removeClass('hidden')
          $form_input.children('input').prop('type', 'text')
        else
          $form_input.addClass('hidden')
          $form_input.children().addClass('hidden')
          $form_input.children('input').prop('type', 'hidden')
