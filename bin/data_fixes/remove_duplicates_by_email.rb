def remove_duplicates(u)
  if User.where(email: u.email).where.not(id: u.id).any?
    member = u
    duplicates = User.where(email: u.email).where.not(id: u.id, email: nil).where.not(email: "")
    duplicates.each do |d|
      user = d
      puts "Updating associations...".green
      [:authentications, :article, :registrations, :logged_actions, :comments, :ya_lider_participants].each do |association|
        user.send(association).each do |obj|
          result = obj.update_attributes user_id: member.id
          unless result
            if obj.class == ::Event::Registration
              obj.destroy
              puts "#{obj.class} ##{obj.id} was destroyed".red
            else
              obj.remove
              puts "#{obj.class} ##{obj.id} was removed".red
            end
          end
        end
      end
      user.subscriptions.each { |s| s.update_attributes! receiver_id: member.id }
      puts "Updating attributes...".green
      [:birth_date, :mobile_phone, :patronymic, :motto, :ticket, :parent_id, :municipality, :locality, :school, :password_digest, :role, :state, :token].each do |attribute|
        if user.send(attribute).present?
          member.update_attributes! attribute => user.send(attribute)
        end
      end
      puts "News migration...".green
      News.where(user_id: user.id).update_all user_id: member.id
      puts "Tags migration...".green
      Tag.where(target_id: user.id, target_type: 'Member').update_all target_id: member.id
      puts "Event organizer_id migrations...".green
      Event.where(organizer_id: user.id, organizer_type: [ 'User', 'Member' ]).update_all organizer_id: member.id
      puts "Event creator_id migrations...".green
      Event.where(creator_id: user.id).update_all creator_id: member.id
      unless User.where(email: user.email).count == 1
        puts "Destroy old user...".red
        user.destroy
        puts "User #{user.id} removed".red
      end
    end
  end
end

Member.where.not(email: nil).where.not(email: "").find_each do |u|
  remove_duplicates u
end
Questionary.where.not(email: nil).where.not(email: "").find_each do |u|
  remove_duplicates u
end
User.where.not(email: nil).where.not(email: "").find_each do |u|
  remove_duplicates u
end
