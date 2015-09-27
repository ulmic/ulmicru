module Notifications
  include Notifications::Types

  class Notification
    def self.to_send(type, **params)
      senderObj = "Notifications::Types::#{type.to_s.classify}".constantize
      senderObj.send_notification(params)
    end
  end
end
