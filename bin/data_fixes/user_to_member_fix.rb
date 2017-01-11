if ARGV.count == 2
  user = User.find ARGV[0]
  member = Member.find ARGV[1]
  puts "Updating associations...".green
  [:authentications, :article, :registrations, :logged_actions, :comments].each do |association|
    user.send(association).each do |obj|
      obj.update_attributes! user_id: member.id
    end
  end
  user.subscriptions.each { |s| s.update_attributes! receiver_id: member.id }
  puts "Updating attributes...".green
  [:password_digest, :role, :state, :token, :email].each do |attribute|
    member.update_attributes! attribute => user.send(attribute)
  end
  puts "Destroy old user...".green
  user.destroy
else
  raise 'You should arguments: user.id, member.id'
end
