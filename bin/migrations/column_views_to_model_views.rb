[Article, News].each do |type|
  count = type.count
  type.find_each.with_index do |instance, index|
#instance = News.where.not(views: 0).order(:views).first
    sql = "INSERT INTO views (record_id, record_type, user_id, created_at, updated_at) VALUES "
    unless instance.views == 0
      values = instance.views.times.map do |view|
        "(#{instance.id}, '#{instance.class.name}', NULL, '#{DateTime.now.to_s}', '#{DateTime.now.to_s}')"
      end.join(', ')
      ActiveRecord::Base.connection.execute "#{sql} #{values}"
    end
    print "#{index} of #{count}\r".green
  end
end
