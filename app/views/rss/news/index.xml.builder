xml.rss version: '2.0', 'xmlns:dc' => 'http://purl.org/dc/elements/1.1/', 'xmlns:ya' => 'http://blogs.yandex.ru/yarss/', 'xmlns:wfw' => 'http://wellformedweb.org/CommentAPI/' do
  xml.channel do
    xml.title t('.title')
    xml.description t('.description')
    xml.link root_url
    xml.language 'ru'
    xml.tag! 'ya:more', next_page
    xml.image do
      xml.url 'http://ulmic.ru/assets/apps/logo-mic-square.png'
      xml.width 100
      xml.height 100
    end

    for news in @news
      xml.item do
        xml.guid news_url(news), isPermaLink: true
        xml.author member_url(news.member.ticket)
        xml.pubDate news.published_at.to_s(:rfc822)
        xml.link news_url(news)
        xml.description news.lead
        xml.title news.title
        xml.category news.category
        xml.tag! 'dc:creator', news.member.decorate.short_name
        xml.tag! 'dc:author', news.member.decorate.short_name
      end
    end
  end
end
