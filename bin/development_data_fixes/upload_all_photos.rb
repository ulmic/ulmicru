if ARGV[0].present?
  image = Rails.root.join(ARGV[0]).open
  ActiveRecord::Base.logger.level = 1
  hash = { News => :photo, Event => :main_photo, ActivityLine => :logo, Member => :avatar, Delivery::Campaign => :image,
           Ckeditor::Picture => :data, Image => :file }
  hash.each do |type, attr|
    puts type.to_s.green
    count = type.count
    type.find_each.with_index do |obj, index|
      obj.send "#{attr}=", image
      obj.save!
      print "#{type} #{index} of #{count}\r"
    end
  end
else
  puts "You should send relative path to image".red
end
