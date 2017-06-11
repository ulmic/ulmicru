class Web::ApplicationController < ApplicationController
  before_filter :load_categories_tree
  before_filter :notification_count
  before_filter :load_members_menu

  include Concerns::NotificationManagment
  include Concerns::NotificatableItems
  include Organization::PeopleHelper
  include Concerns::TeamsParamsHelper

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
        redirect_rule = RedirectRule.find_by_old_path(request.env['PATH_INFO'])
        if redirect_rule.present?
          redirect_to redirect_rule.redirect_to
        else
          render 'web/pages/shared/server_error', status: 500
        end
      end
  end

  protected

  def load_categories_tree
    @first_category = Category.includes(:articles).find configus.categories.who_we_are
    @about_site_category = Category.includes(:articles).find configus.categories.site_mic
    @corporative_category = Category.includes(:articles).find configus.categories.corporative_projects
    if signed_in?
      @korporative_category = Category.find configus.categories.corporative_projects
    end
    @activity_lines = ActivityLine.official.decorate
    @feedback = FeedbackForm.new_with_model
    @rss_article_id = 19
  end

  def load_members_menu
    if current_user&.is_member? && current_user&.is_header?
      @led_teams = current_user.led_teams.decorate
    end
  end

  def notification_count
    if signed_in?
      @notification_count = Concerns::NotificatableItems.items(current_user.id).map do |collection_type|
        collection_type.to_s.camelize.constantize.need_to_review.count
      end.sum
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

  def choose_teammates
    @teammates = User.where.not(type: nil)
  end

  def choose_users
    @users = User.presented.decorate
  end
end
