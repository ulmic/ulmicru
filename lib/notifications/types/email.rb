module Notifications
  module Types

    class Email
      def self.to_send(params)
        UserMailer.send(params[:theme], params[:object], params[:user]) 
      end
    end
  end
end
