system('clear');

puts 'Hi! I\'am a script who transfer all materials from old ulmic\'s database!'

#---------Initialization-----------
puts 'Initialization...'

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mysql2'
require 'action_view'

include ActionView::Helpers::SanitizeHelper
#-----------1st verification for wright input------------
while true
  print 'Hide main content of news from output(Y/n)?'
  hide_body = gets
  hide_body.gsub!("\n", "y").downcase!
  if(hide_body.chars.length == 1 && (hide_body.include?('n') || hide_body.include?('y')))
    break
  end
end
print "Ok...\n"
#-------------End 1st verification----------------------
#
#-----------2nd verification for wright input-----------
while true
  print 'Delete copy of uploaded image(Y/n)?'
  delete_copy = gets
  delete_copy.gsub!("\n", "y").downcase!
  if(delete_copy.chars.length == 1 && (delete_copy.include?('n') || delete_copy.include?('y')))
    break
  end
end
print "Ok...\n"
#-------------End 2nd verification----------------------

puts 'Initialization successfully executed...'
#---------End Initialization------
#
#

puts 'Connecting to database \'iliin_mhok\'...'
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "root", :database => "iliin_mhok")
puts 'Connected...'

puts 'Geting all news...'
records = client.query("SELECT * FROM ulmic_content where not state = '-2'").to_a
puts "Count: #{ + records.count.to_s}..."
puts 'Done...'
=begin
#---------each of all records------
  puts'--------------------------'
  current_paginator_url = PAGE_URL + '/index.php?start=' + $page_iterator.to_s
  puts '| Opening page => ' + current_paginator_url
  page = Nokogiri::HTML(open(current_paginator_url))
  puts '| Done...'
  puts'--------------------------'
  #-------each of all links-----
  page
    .css('.blog_articletext, .contentpagetitle, .blog_articletext_noimage')
    .each_slice(2) do |link, news_lead| 

    3.times {puts} 
    puts 'Found link to material: ' + link.text.strip[0, 50].delete("\r\n") +'...   ===>   ' + link['href']
    puts 'Opening material\'s page...'
    news_page = Nokogiri::HTML(open(PAGE_URL + link['href']))
    puts 'Done...'

    #-------------Parsing Body---------
    puts 'Parsing news...'

    news_title = link.text.strip.delete("\r\n")
    puts 'Found title: ' + news_title[0, 50] + '...'
    
    news_lead = news_lead.text.strip.delete("\r\n")
    puts 'Found lead: ' + news_lead[0, 50] + '...'

    news_published_at = DateTime.parse(news_page.css('.createdate').text + ' +0300')
    puts 'Published at: ' + news_published_at.to_s

    news_body = news_page.css('.article-text')
    puts 'Found body...'
    puts 'Finding tags...'
    puts 'Deleting all finding tags...'
    news_body.css('.tag').remove
    puts 'Deleted...'
    
    news_first_photo_text = 'http://www.ulmic.ru' + news_body.css('img')[0]['src']
    puts 'Found photo of news: ' + news_first_photo_text
    news_photo = PhotoUploader.new 
    news_photo.store! (news_first_photo_text)
    news_body.css('img')[0].remove
    puts 'Removed from body\'s context'

    news_body_text = news_body.to_s.strip
    if show_all_news_body_content == 1 
      puts
      puts '--------------'
      puts '||||Body:|||||'
      puts '---------------------------------------------------------------------------'
      puts news_body_text
      puts '---------------------------------------------------------------------------';
      puts
    end 


    puts 'Saving...'
    silence_stream(STDOUT) do
      n = News.new(:body => news_body_text,
                   :title => news_title,
                   :lead => news_lead,
                   :published_at => news_published_at,
                   :created_at => news_published_at,
                   :updated_at => news_published_at,
                   :user_id => nil)
      puts news_first_photo_text
      n.remote_photo_url = news_first_photo_text
      n.save!
    end
    puts 'Done...'
    3.times{puts}
    #----end of parsing body-------
  end
  #-----end each of all links-----
  $page_iterator += 10
end
#-----end each of all pages------

puts 'All right. It\'s Done...' 
=end
