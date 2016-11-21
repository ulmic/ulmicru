module Concerns
  module NotificationManagment
    include Notifications

    def send_notification(user, object, theme, token: false)
      if token
        user.generate_token
        user.save!
      end
      notification_params = {
        user: user,
        object: object,
        theme: theme
      }
      Notification.to_send :email, notification_params
    end
  end
end
