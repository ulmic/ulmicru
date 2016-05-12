class Web::ApplicationController < ApplicationController
  before_filter :load_categories_tree
  before_filter :notification_count

  include Concerns::NotificationManagment
  include Concerns::NotificatableItems

  if Rails.env.staging?
    before_filter :required_basic_auth!
  end

  if Rails.env.production?
    rescue_from ActionController::RoutingError,
                ActionView::MissingTemplate,
                ActiveRecord::RecordNotFound,
                NoMethodError do |exception|
      Rails.logger.warn "ERROR MESSAGE: #{exception.message}"
      Rails.logger.warn "BACKTRACE: #{exception.backtrace.first(30).join("\n")}"
      redirect_rule = RedirectRule.find_by_url(request.env['PATH_INFO'])
      if redirect_rule.present?
	redirect_to redirect_rule.redirect_to
      else
	render '/web/pages/shared/_server_error', status: 500
      end
    end
  end

  def load_categories_tree
    @first_category = Category.find_by_name 'Кто мы такие'
    @about_site_category = Category.find_by_name 'Сайт МИЦ'
    @corporative_category = Category.find_by_name 'Корпоративные проекты'
    contact_category = Category.find_by_name 'Контакты'
    @contact_article = contact_category.articles.first if contact_category
    if signed_in?
      @korporative_category = Category.find_by_name 'Корпоративные проекты'
    end
    @feedback = FeedbackForm.new_with_model
    @rss_article_id = 19
    # @month_article статья месяца
    #@month_article = Article.where(id: 22).first
  end

  def notification_count
    if signed_in? && current_user.role.admin?
      @notification_count = 0
      Concerns::NotificatableItems.items.each do |collection_type|
        @notification_count += collection_type.to_s.capitalize.constantize.unviewed.count
      end
    end
  end

  def add_comment
    @comment = Comment.new
  end

  def choose_members
    @members = Member.presented.decorate
  end

  def choose_teams
    @teams = Team.active.visible.decorate
  end
end
