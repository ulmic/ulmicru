system('clear');

puts 'Hi! I\'am a script who transfer all materials from old ulmic\'s database!'

#---------Initialization-----------
puts 'Initialization...'

require "#{File.dirname(File.dirname(__FILE__))}/config/environment.rb"
include ActionView::Helpers::SanitizeHelper

old_stdout = $stdout #save stdout
output = File.open( "log/transfer_news.errors.log", "w" ) #output to file for erorrs
output << "HI! This is some errors...\n\n\n"
@found_users = {}
count = 0
#-----------1st verification for wright input------------
while true
  print 'Hide main content of news from output(Y/n)?'
  hide_body = gets.chomp.downcase
  break  if hide_body.chars.length <= 1 && ['y', 'n'].any? {|word| hide_body.include? word}
end
print "Ok...\n"
#-------------End 1st verification----------------------
#
#-----------2nd verification for wright input-----------
while true
  print 'Delete copy of uploaded image(Y/n)?'
  delete_image = gets.chomp.downcase
  break  if delete_image.chars.length <= 1 && ['y', 'n'].any? {|word| delete_image.include? word}
end
print "Ok...\n"
#-------------End 2nd verification----------------------

def find_user(user_name)
  user_name = user_name[0..user_name.index(",")-1] if user_name.index(",")
  name = user_name.split(" ")
  usr = Member.where(:first_name => name[0]).where(:last_name => name[1]).first if name.count > 1
  usr = Member.where(:first_name => name[1]).where(:last_name => name[0]).first if !usr && name.count > 1
  return usr
end

def get_news_owner
  @current_owner_id = @current_owner_id == 2? 4 : 2
  Member.find(@current_owner_id)
end

def skip_news?(record)
  a = strip_tags record["introtext"]
  b = strip_tags record["fulltext"]
  b == ""  && a == ""
end

def lead_parser(news, lead)
  if lead != ""
    lead = Nokogiri::HTML(lead)
    lead.search("img").each_slice(1) do |e|

    end
  end
end

puts 'Initialization successfully executed...'
#---------End Initialization------
#
#

puts 'Connecting to database \'iliin_mhok\'...'
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "root", :database => "iliin_mhok")
puts 'Connected...'

puts 'Geting all news...'
records = client.query("SELECT * FROM ulmic_content where not state = '-2'").to_a
puts 'Deleting unpublished...'
records.delete_at(3001)
puts 'Sorting news by \'publish_up\''
records = records.sort_by do |record|
  record["publish_up"]
end
puts 'Done...'
puts "Count: #{records.count.to_s}..."
#------------each of all records------------------------
records.each do |record|
  next if skip_news? record

  news = News.new

  news.title = strip_tags record["title"]
  puts "Found news: #{news.title}"

  news.lead = strip_tags record["introtext"]
  #puts "Found lead of news: #{news.lead}"

  news.body = strip_tags record["fulltext"]
  news.body = news.lead if news.body == ""



  if  hide_body == "n"
    puts "Found body of news: #{news.body}"
  end

  news.published_at = record["publish_up"]

  news.state = :confirmed

  news.member = find_user(record["created_by_alias"])

  if !news.member
    news.member = get_news_owner
  else
    @found_users[record["created_by_alias"]] = news.title
  end
  
  puts "Try to Save news..."
  news.save
  #show info about errors
  if news.errors.count > 0
    $stdout = output

    puts "--------------------------------------------------------------------------------------------------------\n"
    puts "--------------------------------------------------------------------------------------------------------\n"
    puts "--------------------------------------------------------------------------------------------------------\n"
    puts "--------------------------------------------------------------------------------------------------------\n\n"
    puts "---id: #{record["id"]}\n\n"
    puts "---Title: #{record['title']}\n\n"
    puts "---Model errors: \n"
    ap news.errors
    puts "---Model: \n"
    ap news
    puts "---Record:  \n"
    ap record
    puts "---User: #{record["created_by_alias"]}\n\n"
    puts "--------------------------------------------------------------------------------------------------------\n"
    puts "--------------------------------------------------------------------------------------------------------\n"
    puts "--------------------------------------------------------------------------------------------------------\n"
    puts "--------------------------------------------------------------------------------------------------------\n\n\n\n\n"
    $stdout = old_stdout

    puts 'News NOT saved'
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
    next
  end

  puts "News saved..."
  count += 1
  @start_index = News.last[:id] if count == 1
  progress = count * 1.0 / records.count
  puts "News.id = #{news[:id]} Count : #{count}; Progress: #{progress.round(5) * 100.0}%"
end

ap @found_users
@end_index = News.last[:id]
puts "to destroy type this: \"News.where(:id => #{@start_index}..#{@end_index}).destroy_all\""
puts 'Closing erorrs stream...'
output.close 
puts 'All right. It\'s Done...' 
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

=end
