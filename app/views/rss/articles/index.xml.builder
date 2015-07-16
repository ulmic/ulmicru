xml.rss rss_params do
  xml.channel do
    header xml

    for article in @articles
      xml.item do
        xml.guid article_url(article), isPermaLink: true
        xml.author root_url
        xml.pubDate article.created_at.to_s(:rfc822)
        xml.link article_url(article)
        xml.description article.lead
        xml.title article.title
        xml.category article.category.name
      end
    end
  end
end
