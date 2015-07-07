$ ->
  $('.new_comment').on('ajax:success', (xhr, data) ->
    alert 'yes'
  ).on 'ajax:error', (xhr, data) ->
    alert 'fuck'
