for article in @articles
  xml << render('item', xml: xml, item: article)
end
