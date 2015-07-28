module Web::UsersHelper
  def users_hash(users)
    users_hash = {}
    users.each do |user|
      users_hash[user.select_presentation] = user.id
    end
    users_hash
  end
end
