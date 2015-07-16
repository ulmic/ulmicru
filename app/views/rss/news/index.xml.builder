xml.rss rss_params do
  xml.channel do
    header xml

    for news in @news
      xml<< render('item', xml: xml, item: news)
    end
  end
end
