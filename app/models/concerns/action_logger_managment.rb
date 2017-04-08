module Concerns
  module ActionLoggerManagment
    def logged_actions_with(**params)
      LoggedAction.where params.merge(user_id: self.id)
    end

    def logged_actions_associated_users
      @users ||= User.where id: logged_actions_list.map(&:user_id)
      @users = @users + [User.find(creator_id)] if self.try(:creator_id)
      @users = @users + [User.find(user_id)] if self.try(:user_id)
      @users = @users.uniq
    end

    def feeds
      (logged_actions_list + admin_comments).sort { |a, b| a.created_at <=> b.created_at }
    end

    private

    def logged_actions_list
      type == 'Questionary' ? as_record_logged_actions : logged_actions
    end

  end
end
