module Concerns
  module NotificationManagment
    def send_notification(user, object, theme)
      Notifications::Sender.send user, object, theme
    end
  end
end
