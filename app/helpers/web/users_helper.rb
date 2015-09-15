module Web::UsersHelper
  def users_hash(users, options = {})
    users_hash = {}
    users.each do |user|
      users_hash[user.select_presentation(options)] = user.id
    end
    users_hash
  end
end
