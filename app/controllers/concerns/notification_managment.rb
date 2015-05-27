module Concerns
  module NotificationManagment
    def send_notification(user, object, theme)
      user.generate_token
      user.save
      Notifications::Sender.send user, object, theme
    end
  end
end
