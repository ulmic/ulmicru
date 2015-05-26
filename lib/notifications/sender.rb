module Notifications
  class Sender
    def self.send(user, object, theme)
      UserMailer.send(theme, object, user)
    end
  end
end
