$ ->
  comment_template = (comment) ->
    "<div class='row comment'>
      <div class='small-2 columns'>
        <img src='#{comment.image}' alt='Small muptah5vzqy' />
      </div>
      <div class='small-9 columns text'>
        <h4>
          #{comment.name}
        </h4>
          #{comment.text}
      </div>
      <div class='small-1 columns'>
        <div class='remove' data-comment-id='#{comment.id}'>
          <i class='fa fa-remove'>
          </i>
        </div>
      </div>
    </div>"

  append_comment = (comment) ->
    $comment_form = $('.comment-form').last()
    $comment_form.before comment_template comment
    $('#new_comment #comment_text').val ''

  $('.new_comment').on('ajax:success', (xhr, data) ->
    if document.URL.includes('petitions')
      alert 'Комментарий добавлен'
    else
      append_comment data
    return
  ).on 'ajax:error', (xhr, data) ->
    alert 'error'
    return

  init_remove_button = ->
    $('.remove').click ->
      id = $(@).data('commentId')
      $comment_row = $(@).parents('.row.comment').first()
      $.ajax {
        url: Routes.api_comment_path(id)
        method: 'DELETE'
        success: ->
          $comment_row.fadeOut 500, ->
            $comment_row.remove()
        error: ->
          alert 'error'
      }

  init_remove_button()
  $('body').on 'DOMNodeInserted', '.comment', ->
    init_remove_button()
