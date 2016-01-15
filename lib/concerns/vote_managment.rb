module VoteManagment
  def rating
    votes.map(&:difference).sum
  end
end
