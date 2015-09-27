module Concerns
  module NotificationManagment
    def send_notification(user, object, theme)
      user.generate_token
      user.save
      notification_params = {
        user: user,
        object: object,
        theme: theme
      }
      Notifications.to_send :email, notification_params
    end
  end
end
