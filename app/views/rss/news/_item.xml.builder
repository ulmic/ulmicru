xml.item do
  xml.guid news_url(item), isPermaLink: true
  xml.author root_url
  xml.pubDate item.published_at.to_s(:rfc822)
  xml.link news_url(item)
  xml.description item.lead
  xml.title item.title
  xml.category item.category
  xml.enclosure url: "#{configus.full_host}#{item.photo.event_main_page_version.url}", type: 'image/jpeg'
  xml.tag! 'dc:creator', item.member.decorate.short_name
end
