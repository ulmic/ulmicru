xml.rss rss_params do
  xml.channel do
    header xml

    for article in @articles
      xml << render('item', xml: xml, item: article)
    end
  end
end
