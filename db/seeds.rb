pages = { not_found: '404', server_error: '500', changelog: 'changelog' }
pages.keys.each do |slug|
  page = Page.find_by slug: slug
  Page.create slug: slug, view: slug, title: pages[slug] unless page
end

['Кто мы такие', 'Контакты', 'Сайт МИЦ'].each do |name|
  category = Category.find_by_name name
  Category.create name: name unless category
end
contact_category = Category.find_by_name 'Контакты'
contact_article = contact_category.articles.first
Article.create title: 'Контакты', view: 'contacts', category_id: contact_category.id, user_id: 1 unless contact_article

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
municipalities = ['г. Ульяновск', 'г. Димитровград', 'г. Новоульяновск', 'Чердаклинский район', 'Тереньгульский район', 'Базарносызганский район', 'Радищевский район', 'Новоспасский район']
municipalities.each do |municipality|
  t = Team::Departament.find_by_municipality municipality
  Team::Departament.create municipality: municipality, title: municipality, state: :active unless t
end
