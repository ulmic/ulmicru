c = ActivityLines::Corporative::Confession.find(227)
c.arguments.each do |a|
  a.update_attributes! confession_id: 222
end
c.destroy
