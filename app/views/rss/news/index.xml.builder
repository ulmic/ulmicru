xml.rss rss_params do
  xml.channel do
    header xml

    for news in @news
      xml.item do
        xml.guid news_url(news), isPermaLink: true
        xml.author root_url
        xml.pubDate news.published_at.to_s(:rfc822)
        xml.link news_url(news)
        xml.description news.lead
        xml.title news.title
        xml.category news.category
        xml.tag! 'dc:creator', news.member.decorate.short_name
      end
    end
  end
end
