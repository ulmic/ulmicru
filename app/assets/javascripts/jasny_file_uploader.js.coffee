$ ->
  init_jasny_file_uploader = ->
    $fileinput_preview = $('.fileinput-preview.thumbnail')
    $fileinput_preview.hide()
    $('input.file').click ->
      $fileinput_preview.show()
      $('.preview').hide()
    $('a.remove').click ->
      $fileinput_preview.hide()
      $('.preview').show()
  init_jasny_file_uploader()
