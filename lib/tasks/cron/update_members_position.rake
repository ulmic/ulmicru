namespace :members do
  desc 'Update main position'
  task update_member_main_position: :environment do
    count = Member.confirmed.count
    Member.confirmed.find_each.with_index do |member, index|
      main_position_title = member.decorate.main_position_title
      unless member.update_attributes main_position_title: main_position_title
        puts member.id
        puts member.email
        puts member.errors.messages
        break
      end
      print "#{index} of #{count}\r"
    end
    puts "Members updated!"
  end
end
