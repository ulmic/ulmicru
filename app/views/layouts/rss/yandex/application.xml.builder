xml.instruct! :xml, version: '1.0', encoding: 'UTF-8'
xml.rss yandex_rss_params do
  xml.channel do
    yandex_header xml

    xml << yield
  end
end
