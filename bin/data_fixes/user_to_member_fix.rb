if ENV['USER_ID'].present? && ENV['MEMBER_ID'].present?
  user = User.find ENV['USER_ID']
  member = Member.find ENV['MEMBER_ID']
  puts "Updating associations...".green
  [:authentications, :article, :registrations, :logged_actions, :comments].each do |association|
    user.send(association).each do |obj|
      obj.update_attributes! user_id: member.id
    end
  end
  user.subscriptions.each { |s| s.update_attributes! receiver_id: member.id }
  puts "Updating attributes...".green
  [:password_digest, :role, :state, :token].each do |attribute|
    member.update_attributes! attribute => user.send(attribute)
  end
  puts "Destroy old user...".green
  user.destroy
else
  raise 'You should add arguments: USER_ID and MEMBER_ID. Like this USER_ID=1 MEMBER_ID=2 rails run bin/data_fixes/user_to_member.rb'.red
end
