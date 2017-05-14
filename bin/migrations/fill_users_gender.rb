count = User.count
User.find_each.with_index do |user, index|
  user.set_gender!
  print "#{index} of #{count}\r"
end
puts User.where(gender: nil).count
