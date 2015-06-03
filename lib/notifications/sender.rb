module Notifications
  class Sender
    def self.send(user, object, theme)
      UserMailer.delay.send(theme, object, user)
    end
  end
end
