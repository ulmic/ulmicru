page = Page.find_by slug: :not_found
Page.create slug: :not_found, view: :not_found, title: '404' unless page
['Кто мы такие', 'Контакты'].each do |name|
  category = Category.find_by_name name
  Category.create name: name unless category
end
contact_category = Category.find_by_name 'Контакты'
contact_article = contact_category.articles.first
Article.create title: 'Контакты', category_id: contact_category.id, user_id: 1 unless contact_article
