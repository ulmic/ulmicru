system('clear');

puts 'Hi! I\'am a script who downloads all materials from ulmic.ru'

#---------Initialization-----------
puts 'Initialize...'

require 'rubygems'
require 'nokogiri'
require 'open-uri'

include ActionView::Helpers::SanitizeHelper

show_all_news_body_content = 0 

PAGE_URL = "http://ulmic.ru" unless defined? PAGE_URL

puts 'Initialized...'
#---------End Initialization------
#---------each of all pages------
$page_iterator = 0
while ($page_iterator <= 1730) do
  
  current_paginator_url = PAGE_URL + '/index.php?start=' + $page_iterator.to_s 
  puts 'Opening page => ' + current_paginator_url
  page = Nokogiri::HTML(open(current_paginator_url))
  puts 'Done...'
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

    news_first_photo_text = 'http://www.ulmic.ru' + news_body.css('img')[0]['src']
    puts 'Found photo of news: ' + news_first_photo_text
    news_photo = PhotoUploader.new 
    news_photo.store! (news_first_photo_text)


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
