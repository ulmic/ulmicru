#= require jquery
#= require i18n_setup


winner_id = (element) ->
  $(element).attr('data-winner-id')

close_winner_info = ->
  $('.winner_info').each ->
    if $(this).is(':visible')
      $(this).hide()
      id = $(this).attr('id').substring($(this).attr('id').lastIndexOf('_'))
      $("#winner_cell#{id}").show()
      return
    return

participant_id = (element) ->
  $(element).attr('data-participant-id')

close_info = ->
  $('.participant_info').each ->
    if $(this).is(':visible')
      $(this).hide()
      id = $(this).attr('id').substring($(this).attr('id').lastIndexOf('_'))
      $("#participant_cell#{id}").show()
    return
  return

window.fill_popup = (element) ->
  $popup = $('#popup')
  $data = element.data()
  $('#popup h2.short_name').first().html($data.shortName)
  $('#popup img.img-rounded').first().prop('src', $data.image)
  $('#popup div.age').first().html($data.age)
  $('#popup div.home_city').first().html($data.homeCity)
  $('#popup div.school').first().html($data.school)
  $('#popup div.average').first().html("#{I18n.t('activerecord.attributes.user.average')} #{$data.average}")
  return

open_popup = ->
  fill_popup($("#participant_cell_#{window.location.hash.substring(1)}"))
  $("#popup").show()
  $('#blackout').show()
  scrollPos = $(window).scrollTop()
  $('html').scrollTop(scrollPos)

$main_question = $('#main_question')

changes = ->
  $questions = $('#questions')
  $poll = $('.poll')
  if $('body').width() > 767
    $main_question.css('margin-left', '0px')
  else
    $main_question.css('margin-top', '0px')
  $main_question.parents('div').first().removeClass('col-md-offset-4')
  $questions.fadeIn()
  $main_question.removeClass 'link'
  $main_question.unbind 'click'
  $poll.fadeIn()

init_main_question = ->
  parent_width = $main_question.parents().first().width()
  $main_question.css 'height', "#{parent_width}px"
  $main_question.css 'width', "#{parent_width}px"
  $main_question.click ->
    if $('body').width() > 767
      $(this).animate {
        marginLeft: "+=#{parent_width}"
      }, 1000, changes
    else
      $(this).css { margintop: "+=#{parent_width}" }
      changes()

news_template = (news) ->
  "<div class='col-md-4 news link' data-href='http://ulmic.ru/news/#{news.id}'>
    <div class='title'>
      #{news.title}
    </div>
    <div class='body'>
      <img alt='Ulmic' src='http://ulmic.ru/#{news.photo}' />
      #{news.text}
    </div>
  </div>"

download_news_from_ulmicru = ->
  $.ajax {
    url: 'https://ulmic.ru/api/news'
    data: {
      count: 3
      tag: {
        tag_type: 'link'
        target_type: 'ActivityLine'
        title: 'Лидер'
      }
    }
    dataType: 'json'
    success: (data) ->
      $(data).each ->
        $('.row.for_news').append news_template @
      $('.link').click ->
        location.href = $(this).attr('data-href')
  }

$(document).ready ->
  download_news_from_ulmicru()
  document_width = screen.width
  document_height = screen.height
  if $(document).width() >= '991'
    $('.full_width').width(screen.width - 75)
    width_of_parent = $('.full_width').parents('div').first().width()
    margin_left = (width_of_parent - screen.width + 67) / 2
    $('.full_width').css({
      paddingLeft: -margin_left,
      paddingRight: -margin_left - 10,
      marginLeft: margin_left
    })
    $('iframe').prop('width', $('.container').width())
    $('iframe').prop('height', $('iframe').first().width() * 9 / 16)
    if window.location.hash != ''
      open_popup()
#    $('.winner_avatar').tooltip({
#      html: true,
#      content: ->
#        return $(this).attr('data-original-title')
#    })
    participant_cells_width = 0
    $('.participant_cell').each ->
      participant_cells_width += $(@).width()
    participant_images_margin = ($('.participants_images').width() - participant_cells_width) / 2
    $('.participants_images div').first().css 'margin-right', participant_images_margin
    $('.participants_images div').first().css 'margin-left', participant_images_margin
  else
    count = $('.news').length
    $('.for_news').height(240 * count)
    $('iframe').prop('width', $('iframe').first().parent().first().width())
    $('iframe').prop('height', $('iframe').first().width() * 9 / 16)
    $('.winner_cell.main_avatar').click ->
      close_winner_info()
      id = winner_id this
      $("#winner_info_#{id}").slideDown("show")
      $(this).hide()
      return
    $('.winner_avatar.in_info').click ->
      id = winner_id this
      $("#winner_cell_#{id}").slideDown("show")
      $("#winner_info_#{id}").slideUp("hide")
  $('.full_width').css('background-size', "#{document_width}px #{document_height}px")
  $('.participants_images_button').click ->
    if $('.participants_images').is(':visible')
      $('.participant_cell').slideUp()
      $('.participants_images').hide()
    else
      $('.participants_images').show()
      $('.participant_cell').slideDown("slow")
    return
  $('#participant_cell_12').unbind('click')
  $('#participant_cell_12').click ->
    close_info()
    id = participant_id this
    $("#participant_info_#{id}").slideDown("show")
    $(this).hide()
    return
  $('.winners_images_button').click ->
    if $('.winners_images').is(':visible')
      $('.winner_cell').slideUp()
      $('.winners_images').hide()
    else
      $('.winners_images').show()
      $('.winner_cell').slideDown("slow")
    return
  return

$ ->
  init_main_question()
  return
