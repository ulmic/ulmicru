$ ->
  $('form#new_place').on 'ajax:success', (e, data) ->
    $('#placeModal .close-reveal-modal').trigger 'click'
    option = new Option(data.title, data.id)
    option.selected = true
    $('#event_place_ids').append option
    $('#event_place_ids').trigger 'change'
  $('form#new_place').on 'ajax:error', ->
    alert 'error'

  $('#event_place_ids').select2({
    multiple: true
    minimumInputLength: 2
    ajax: {
      url: Routes.api_users_places_path()
      data: (term, page) ->
        {
          q: term,
          page: page
        }
      dataType: 'JSON'
      delay: 250
      processResults: (data) ->
        tag_results = []
        $(data).each ->
          tag_results.push { id: this.id, text: this.title }
        {
          results: tag_results
        }
    }
  })
