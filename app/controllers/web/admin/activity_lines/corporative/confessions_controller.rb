class Web::Admin::ActivityLines::Corporative::ConfessionsController < Web::Admin::ActivityLines::Corporative::ApplicationController
  before_filter :choose_members, only: [ :new, :edit ]

  def index
    if params[:search]
      confessions = ActivityLines::Corporative::Confession.search_everywhere params[:search]
    else
      confessions = ActivityLines::Corporative::Confession.send params[:scope]
    end
    @confessions = confessions.page(params[:page]).decorate
  end

  def new
    @confession_form = ::ActivityLines::Corporative::ConfessionForm.new_with_model
  end

  def show
    @confession = ::ActivityLines::Corporative::Confession.find(params[:id]).decorate
    @arguments = @confession.arguments.decorate
    @comments = @confession.comments.active.decorate
  end

  def create
    @confession_form = ::ActivityLines::Corporative::ConfessionForm.new_with_model
    if @confession_form.submit params[:activity_lines_corporative_confession]
      create_tag
      redirect_to admin_activity_lines_corporative_confessions_path
    else
      choose_members
      render action: :new
    end
  end

  def edit
    @confession_form = ::ActivityLines::Corporative::ConfessionForm.find_with_model params[:id]
  end

  def update
    @confession_form = ::ActivityLines::Corporative::ConfessionForm.find_with_model params[:id]
    if @confession_form.submit params[:activity_lines_corporative_confession]
      create_tag
      send_notification @confession_form.member, @confession_form.model, :nominated if confession_confirmed?
      send_notification @confession_form.creator, @confession_form.model, :confirm if confession_confirmed?
      redirect_to edit_admin_activity_lines_corporative_confession_path @confession_form.model
    else
      choose_members
      render action: :edit
    end
  end

  def destroy
    @confession = ::ActivityLines::Corporative::Confession.find params[:id]
    @confession.remove
    redirect_to admin_activity_lines_corporative_confessions_path
  end

  private

  def create_tag
    Tag.create record_type: 'Article',
               record_id: configus.activity_lines.corporative.confession.article_id,
               tag_type: :link,
               target_type: 'Member',
               target_id: params[:activity_lines_corporative_confession][:member_id]
  end

  def confession_confirmed?
    params[:activity_lines_corporative_confession][:state] == 'confirmed' && @prev_object_attributes[:state] != 'confirmed'
  end
end
