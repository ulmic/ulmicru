$ ->
  $('.attribute_access').change ->
    value = 'hidden'
    if $(this).prop('checked') == true
      value = 'visible'
    else
      value = 'hidden'
    $.ajax
      data:
        attribute_access:
          access: value
          member_id: $(this).data().id
          member_attribute: $(this).attr('name')
      url: Routes.users_attribute_accesses_path()
      method: 'POST'
      success: -> alert(I18n.t('notices.web.users.account.attribute_accesses.changed'))
      error: -> alert(I18n.t('notices.web.users.account.attribute_accesses.not_changed'))
    return
  return
