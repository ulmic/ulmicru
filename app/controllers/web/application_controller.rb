class Web::ApplicationController < ApplicationController
  before_filter :load_categories_tree
  before_filter :notification_count

  include Concerns::NotificationManagment

  def load_categories_tree
    @first_category = Category.find_by_name 'Кто мы такие'
    contact_category = Category.find_by_name 'Контакты'
    @contact_article = contact_category.articles.first if contact_category
    if signed_in?
      @korporative_category = Category.find_by_name 'Корпоративные проекты'
    end
    @feedback = FeedbackForm.new_with_model
  end

  def notification_count
    if signed_in? && current_user.role.admin?
      collections = [ :member, :questionary, :news, :event, :user, :feedback ]
      @notification_count = 0
      collections.each do |collection_type|
        @notification_count += collection_type.to_s.capitalize.constantize.unviewed.count
      end
    end
  end

  def add_comment
    @comment = Comment.new
  end
end
