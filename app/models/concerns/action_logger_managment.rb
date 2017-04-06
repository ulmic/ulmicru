module Concerns
  module ActionLoggerManagment
    def logged_actions_with(**params)
      LoggedAction.where params.merge(user_id: self.id)
    end

    def logged_actions_associated_users
      @users ||= User.where id: logged_actions.map(&:user_id)
    end

    def feeds
      (logged_actions + admin_comments).sort_by { created_at }
    end
  end
end
