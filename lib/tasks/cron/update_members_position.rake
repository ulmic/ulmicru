namespace :members do
  desc 'Update main position'
  task update_member_main_position: :environment do
    count = Member.confirmed.count
    Member.confirmed.find_each.with_index do |member, index|
      begin
      main_position = member.positions.to_a.sort_by! { |p| PositionList.list.index(p.title) }.first
      rescue
        puts member.id
        break
      end
      if main_position
        member.update_attributes! main_position_id: main_position.id
      end
      print "#{index} of #{count}\r"
    end
    puts "Members updated!"
  end
end
