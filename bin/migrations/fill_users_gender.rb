count = User.count
User.find_each.with_index do |user, index|
  user.gender = GenderHelper.detect_gender(user.first_name)
  user.save! validate: false
  print "#{index} of #{count}\r"
end
puts User.where(gender: nil).count
