$ ->
  $audience_form = $('#new_delivery_audience')
  $audience_type_input = $('#delivery_audience_audience_type')
  $audience_select2 = $('#delivery_audience_audience_id')
  $audience_select2.hide()
  $audience_select2.empty()
  $audience_form.hide()
  $submit_button = $audience_form.find('input[type=submit]')
  $('.add-audience').click ->
    if $audience_form.css('display') == 'block'
      $audience_form.slideUp()
    else
      $audience_form.slideDown()

  $audience_type_input.change ->
    value = $(this).val()
    if value == 'event_registrations' || value == 'team' || value == 'project'
      $audience_select2.show()
      $submit_button.prop 'disabled', true
      url = Routes.api_admin_events_path() if value == 'event_registrations'
      url = Routes.api_admin_teams_path() if value == 'team'
      url = Routes.api_admin_projects_path() if value == 'project'
      $audience_select2.select2
        ajax:
          url: url
          data: (term, page) ->
            q: term
          dataType: 'JSON'
          delay: 250
          processResults: (data) ->
            results = []
            $(data).each ->
              results.push
                id: this.id
                text: this.title
            { results: results }
        minimumInputLength: 2
      $audience_select2.on 'select2:select', ->
        unless $(this).val() == ''
          $submit_button.prop 'disabled', false
    else
      $submit_button.prop 'disabled', false
