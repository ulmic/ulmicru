module Concerns
  module ActionLogger
    def log_action(action_type)
      LoggedAction.create! user_id: current_user.id, action_type: action_type
    end
  end
end
