namespace :members do
  desc 'Update main position'
  task update_member_main_position: :environment do
    count = Member.confirmed.count
    Member.confirmed.find_each.with_index do |member, index|
      main_position_id = member.decorate.main_current_position&.id
      member.update_attributes! main_position_id: main_position_id
      print "#{index} of #{count}\r"
    end
    puts "Members updated!"
  end
end
