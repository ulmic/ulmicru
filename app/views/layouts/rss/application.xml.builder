xml.rss rss_params do
  xml.channel do
    header xml

    xml << yield
  end
end
