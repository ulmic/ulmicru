module Web::UsersHelper
  def users_hash(users, options = {})
    users_hash = {}
    users.each do |user|
      users_hash[user.select_presentation(options)] = user.id
    end
    users_hash
  end

  # NOTE not use this twice on one page with different users or options
  def users_cache_hash(users, options = {})
    @_users_cache_hash ||= users_hash(users, options)
  end
end
