puts "Create pages..".green
pages = {
          not_found: '404',
          server_error: '500',
          changelog: 'changelog',
          confession_submissions_petitions_ends: 'confession_submissions_petitions_ends',
          successfully_unsubscribed: :successfully_unsubscribed,
          unsubscribe_successful: :unsubscribe_successful
        }
pages.each do |slug, title|
  page = Page.find_by slug: slug
  Page.create slug: slug, view: slug, title: title unless page
end

puts "Create categories...".green
categories = { 
  who_we_are: 'Кто мы такие',
  contacts: 'Контакты' ,
  site_mic: 'Сайт МИЦ',
  corporative_projects: 'Корпоративные проекты'
}
categories.each do |category, name|
  c = Category.where(id: configus.categories.send(category)).first
  Category.create id: configus.categories.send(category), name: name unless c
end

puts "Create articles...".green
contact_category = Category.find_by_name 'Контакты'
articles = { contacts: 'Контакты', contact_list: 'Контакт-лист', charter: 'Устав' }
articles.each do |article, name|
  a = Article.where(id: configus.articles.send(article)).first
  Article.create id: configus.articles.send(article), title: name, view: article, category_id: contact_category.id, user_id: 1 unless a
end

unless Rails.env.production?
  # Create month article
  puts "Create month article".green
  month_article_id = 21
  about_site_category = Category.find_by_name 'Сайт МИЦ'
  article = Article.where(id: month_article_id).first
  article ||= Article.create title: 'Статья месяца', category_id: about_site_category.id, user_id: 1
  Article.update article.id, id: month_article_id
end

# Create activity lines
puts "Create activity lines..".green
activity_lines = ['Лидер', 'Inформация', 'Право', 'Добро', 'Информационные технологии', 'Диалог культур', 'Корпоративные проекты']
activity_lines.each do |activity_line|
  a = ActivityLine.find_by_title activity_line
  ActivityLine.create title: activity_line unless a
end

#Create teams
puts "Create teams..".green
teams = ['Президиум', 'Руководители областных программ и проектов МИЦ']
teams.each do |team|
  t = Team.find_by_title team
  Team::Administration.create! title: team, description: 'Лучшая команда в мире', type: 'Team::Administration' unless t
end

# Create departaments
puts "Create departaments...".green
municipalities = ['г.Ульяновск', 'г.Димитровград', 'г.Новоульяновск', 'Чердаклинский район', 'Тереньгульский район', 'Базарносызганский район', 'Радищевский район', 'Новоспасский район']
municipalities.each do |municipality|
  t = Team::Departament.find_by_municipality municipality
  Team::Departament.create municipality: municipality, title: municipality, state: :active unless t
end

# Create documents
puts "Create documents...".green
documents = { 4 => 'Положение Признания' }
documents.each do |id, document|
  Document.find_or_create_by title: document
  d = Document.last
  d.update_attributes id: id
end
