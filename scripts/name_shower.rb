client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "root", :database => "iliin_mhok")
records = client.query("SELECT * FROM ulmic_content where state <> '-2'")
h = {}
records.each do |record|
  lead = Nokogiri::HTML.fragment(record["introtext"]).search("img")
  h[record["title"]] = {}
  h[record["title"]][:lead] = Array.new

  lead.each {|e|
    next unless e["src"].include? "http://"
    h[record["title"]][:lead].push e["src"]
  }
  if !h[record["title"]][:lead].empty?
    h[record["title"]].delete :lead
  end
=begin
  unless record["fulltext"].empty?
    body = Nokogiri::HTML.fragment(record["fulltext"]).search("img")
    h[record["title"]][:body] = Array.new

    body.each {|e|
      next unless e["src"].include? "http://"
      h[record["title"]][:body].push e["src"]
    }
    if h[record["title"]][:body].empty?
      h[record["title"]].delete :body
    end
  end
=end
  if(h[record["title"]].empty?)
    h.delete(record["title"])
  end
end
ap h
