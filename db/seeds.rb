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

categories = { who_we_are: 'Кто мы такие', contacts: 'Контакты' , site_mic: 'Сайт МИЦ' }
categories.each do |category, name|
  c = Category.find configus.categories.send category
  Category.create id: configus.categories.send(category), name: name unless c
end

contact_category = Category.find_by_name 'Контакты'
articles = { contacts: 'Контакты', contact_list: 'Контакт-лист' }
articles.each do |article, name|
  a = Article.find configus.articles.send article
  Article.create id: configus.articles.send(article), title: name, view: article, category_id: contact_category.id, user_id: 1 unless a
end

unless Rails.env.production?
  # Create month article
  month_article_id = 21
  about_site_category = Category.find_by_name 'Сайт МИЦ'
  article = Article.where(id: month_article_id).first
  article ||= Article.create title: 'Статья месяца', category_id: about_site_category.id, user_id: 1
  Article.update article.id, id: month_article_id
end

# Create activity lines
activity_lines = ['Лидер', 'Inформация', 'Право', 'Добро', 'Информационные технологии', 'Диалог культур', 'Корпоративные проекты']
activity_lines.each do |activity_line|
  a = ActivityLine.find_by_title activity_line
  ActivityLine.create title: activity_line unless a
end

# Create departaments
municipalities = ['г.Ульяновск', 'г.Димитровград', 'г.Новоульяновск', 'Чердаклинский район', 'Тереньгульский район', 'Базарносызганский район', 'Радищевский район', 'Новоспасский район']
municipalities.each do |municipality|
  t = Team::Departament.find_by_municipality municipality
  Team::Departament.create municipality: municipality, title: municipality, state: :active unless t
end
