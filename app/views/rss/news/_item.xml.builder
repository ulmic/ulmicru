xml.item do
  xml.guid news_url(item), isPermaLink: true
  xml.author root_url
  xml.pubDate item.published_at.to_s(:rfc822)
  xml.link news_url(item)
  xml.description item.lead
  xml.title item.title
  xml.category item.category
  xml.tag! 'dc:creator', item.member.decorate.short_name
end
