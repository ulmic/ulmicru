xml.item do
  xml.guid article_url(item), isPermaLink: true
  xml.author root_url
  xml.pubDate item.created_at.to_s(:rfc822)
  xml.link article_url(item)
  xml.description item.lead
  xml.title item.title
  xml.category item.category.name
end
