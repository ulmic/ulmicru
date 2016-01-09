xml.item do
  xml.title item.title
  xml.link news_url(item)
  xml.description item.lead
  xml.author item.member.short_name
  xml.pubDate item.published_at.to_s(:rfc822)
  xml.category item.category
  xml.enclosure url: "#{configus.full_host}#{item.photo.event_main_page_version.url}", type: 'image/jpeg'
  xml.tag! 'yandex:full-text', strip_tags(item.full_text)
end
