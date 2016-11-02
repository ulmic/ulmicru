$ ->
  $('a.yofication').click ->
    type = $(this).data 'type'
    $(this).data('fields').each ->
      body = $("##{type}_#{this}").val()
      $.ajax {
        url: Routes.api_yofications_path
        method: 'POST'
        data: {
          yofication: {
            user_id: $(this).data('id')
            body: body
          }
        }
        success: (data) ->
          $("##{type}_#{this}").val data.yoficated_body
        error: ->
          alert 'error'
      }
