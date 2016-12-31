module VoteManagment
  def rating
    votes.map(&:difference).sum
  end

  def member_rating
    votes.from_members.map(&:difference).sum
  end

  def member_votes
    votes.from_members.count
  end

  def user_rating
    votes.from_users.map(&:difference).sum
  end

  def user_votes
    votes.from_users.count
  end

  def member_likes
    votes.from_members.likes.count
  end

  def member_dislikes
    votes.from_members.dislikes.count
  end

  def user_likes
    votes.from_users.likes.count
  end

  def user_dislikes
    votes.from_users.dislikes.count
  end
end
