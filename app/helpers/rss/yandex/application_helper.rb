module Rss::Yandex::ApplicationHelper
  def yandex_rss_params
    {
       version: '2.0',
      'xmlns:ya' => 'http://blogs.yandex.ru/yarss/',
      'xmlns:yandex' => 'http://news.yandex.ru',
      'xmlns:media' => 'http://search.yahoo.com/mrss'
    }
  end

  def yandex_header(xml)
    xml.title t('.title')
    xml.description t('.description')
    xml.link root_url
    xml.tag! 'yandex:logo', configus.organization.logo
    xml.tag! 'yandex:logo', { type: :square }, configus.organization.logo
  end
end
