module Concerns
  module NotificationManagment
    include Notifications
    def send_notification(user, object, theme)
      user.generate_token
      user.save!
      notification_params = {
        user: user,
        object: object,
        theme: theme
      }
      Notification.to_send :email, notification_params
    end
  end
end
