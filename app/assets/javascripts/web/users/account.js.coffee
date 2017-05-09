$ ->
  create_subscription = (subscription_type) ->
    $.ajax {
      url: Routes.api_users_account_subscriptions_path()
      data: {
        subscription: {
          subscription_type: subscription_type
        }
      }
      method: 'POST'
      success: ->
        alert('success')
    }

  destroy_subscription = (subscription_type) ->
    $.ajax {
      url: Routes.api_users_account_subscriptions_path()
      data: {
        subscription: {
          subscription_type: subscription_type
        }
      }
      method: 'DELETE'
      success: ->
        alert('success')
    }

  $('select#member_parent_id').select2()
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
      url: Routes.api_users_account_attribute_accesses_path()
      method: 'POST'
      #TODO нормальные алерты
      #success: -> alert(I18n.t('notices.web.users.account.attribute_accesses.changed'))
      #error: -> alert(I18n.t('notices.web.users.account.attribute_accesses.not_changed'))
    return
  # FIXME
  #$('.position_fields').last().remove()
  $('.subscription').click ->
    if $(this).prop('checked') == true
      create_subscription $(this).prop('id')
    else
      destroy_subscription $(this).prop('id')
  return
