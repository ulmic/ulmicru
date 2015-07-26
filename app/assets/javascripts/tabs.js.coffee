#= require jquery-ui/tabs

$ ->
  $('#tabs').tabs()
  $('#tabs ul.nav li').first().addClass 'active'
  init_tabs_links = ->
    $('#tabs ul.nav li a').click (e) ->
      e.preventDefault()
      $('#tabs ul.nav li').removeClass 'active'
      $(this).parents('li').first().addClass 'active'
      if (history.pushState)
        history.pushState(null, null, $(this).attr('href'))
      else
        location.hash = $(this).attr('href')
      update_url_of_page_links()

  open_tab_by_hash = ->
    hash = window.location.hash
    unless hash == ''
      $('#tabs div').removeClass 'active'
      $("#tabs #{hash}").addClass 'active'
      $('#tabs ul.nav li').removeClass 'active'
      $("#tabs ul.nav li a[href=#{hash}]").parents('li').first().addClass 'active'

  update_url_of_page_links = ->
    hash = window.location.hash
    $('ul.pagination li a').each ->
      link = $(this).attr 'href'
      link = link.split('#')[0]
      $(this).prop 'href', "#{link}#{hash}"

  unless $('#tabs').length == 0
    init_tabs_links()
    open_tab_by_hash()
    update_url_of_page_links()
  return
