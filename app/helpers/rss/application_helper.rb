module Rss::ApplicationHelper
  def next_page
    params[:page].present? ? page = params[:page].to_i + 1 : page = 2
    send "#{params[:controller].gsub('/', '_')}_index_url", page: page
  end

  def header(xml)
    xml.title t('.title')
    xml.description t('.description')
    xml.link root_url
    xml.language 'ru'
    xml.image do
      xml.url configus.organization.logo
      xml.width 100
      xml.height 100
    end
  end

  def rss_params
    { version: '2.0', 'xmlns:dc' => 'http://purl.org/dc/elements/1.1/', 'xmlns:ya' => 'http://blogs.yandex.ru/yarss/', 'xmlns:wfw' => 'http://wellformedweb.org/CommentAPI/' }
  end
end
