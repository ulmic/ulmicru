#= require moment
#= require moment/ru
#= require bootstrap-datetimepicker
#= require jquery-validation/dist/jquery.validate
#= require jquery-validation/dist/localization/messages_ru

init_form = ($form) ->
  $form.hide()
  $form.validate()
  $form.on 'submit', (e) ->
    e.preventDefault()
    $.ajax {
      url: $form.prop('action')
      method: 'POST'
      data: {
        project_record: {
          first_name: $('#project_record_first_name').val()
          last_name: $('#project_record_last_name').val()
          patronymic: $('#project_record_patronymic').val()
          birth_date: $('#project_record_birth_date').val()
          email: $('#project_record_email').val()
          phone: $('#project_record_phone').val()
          region: $('#project_record_region').val()
          locality: $('#project_record_locality').val()
          school: $('#project_record_school').val()
          group: $('#project_record_group').val()
          activity_line: $('#project_record_activity_line').val()
          experience: $('#project_record_experience').val()
          reason: $('#project_record_reason').val()
          has_i_note: $('#project_record_has_i_note').val()
        }
      }
      success: ->
        $form.parent().html("<div class='alert alert-success request-sended'> Ваша заявка принята! С вами обязательно свяжется представитель организационного комитета мероприятия, а пока вы можете подписаться на наше сообщество во ВКонтакте <a href='http://vk.com/it_way'>vk.com/it_way</a> и на твиттер <a href='http://twitter.com/developerslogs'>@developerslogs</a>.Ты можешь добавиться в <a href='http://t.me/it_way_chat'>наш telegram-чат</a> и задать все интересующие вопросы.<br/>Также последние новости форума выкладываются на <a href='http://ulmic.ru'>сайт МИЦ</a>. Мы выслали тебе на почту информационное письмо, в котором продублировали все данные.</div>")
        $form.slideUp()
        $.scrollTo ".request-sended"
      error: ->
        $form.after("<p class='alert alert-info'><i class='fa fa-info'></i> Проблемы с подачей заявки? Перейдите в наше сообщество во ВКонтакте <a href='http://vk.com/it_way'>vk.com/it_way</a> и напишите сообщение в сообщество. Либо можете отправить письмо на почту <a href='mailto:admin@ulmic.ru'>admin@ulmic.ru</a>.</p>")
        $form.after("<p class='alert alert-danger'> Произошла ошибка:<br/><br/>" + xhr.responseJSON['errors'] + "</p>")
    }

$.extend($.scrollTo.defaults, {
    axis: 'y',
    duration: 2000
})
$(document).ready ->
  $('.completed').hide()
  $('.not_completed').hide()
  $('.fa-spinner').hide()

  init_form $('form#new_project_record')

  $('.social a').hover ->
    $(this).children('img.white').hide()
    $(this).children('img.gray').show()
    return
  $('.social a').mouseover ->
    $(this).children('img.white').show()
    $(this).children('img.gray').hide()
    return
  $('a.form_show').click (e) ->
    e.preventDefault()
    id = $(@).data('target')
    if $("##{id}").css('display') == 'none'
      $('form').slideUp()
      $("##{id}").slideDown()
    else
      $('form').slideUp()
  $('.btn-outline-dark').click ->
    $(@).parents('div').first().children('.fa-spinner').show()
  $('.scroll').click (e) ->
    e.preventDefault()
    $.scrollTo "##{$(@).data('id')}"

  $('.youtube_video iframe').each ->
    padding_left = $(this).parents().parents().css('padding-left').replace('px', '')
    padding_right = $(this).parents().parents().css('padding-right').replace('px', '')
    width = $(this).parents().parents().width()
    width_100_percent = width - padding_left - padding_right
    $(this).prop 'width', width_100_percent
    $(this).prop 'height', width_100_percent / 16 * 9
  $('.datepicker').datetimepicker()
  $('.link').click ->
    location.href = $(this).data('href')
  return
