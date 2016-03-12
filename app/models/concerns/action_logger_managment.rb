module Concerns
  module ActionLoggerManagment
    def logged_actions_with(**params)
      LoggedAction.where params.merge(user_id: self.id)
    end
  end
end
