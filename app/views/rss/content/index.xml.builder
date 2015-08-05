for post in @content
  instance_name = post.model_name.name.underscore
  xml << render("rss/#{instance_name.pluralize(:en)}/item", xml: xml, item: post)
end
