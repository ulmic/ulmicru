class Web::Admin::ActivityLines::Corporative::ConfessionsController < Web::Admin::ActivityLines::Corporative::ApplicationController
  before_filter :choose_members, only: [ :new, :edit ]
  def index
    @confessions = {}
    @confessions[:confirmed] = ::ActivityLines::Corporative::Confession.confirmed.page(params[:page]).decorate
    @confessions[:unviewed] = ActivityLines::Corporative::Confession.unviewed.page(params[:page]).decorate
    @confessions[:on_vote] = ActivityLines::Corporative::Confession.on_vote.page(params[:page]).decorate
    @confessions[:declined] = ActivityLines::Corporative::Confession.declined.page(params[:page]).decorate
    @confessions[:search] = ActivityLines::Corporative::Confession.search_everywhere(params[:search]).page(params[:page]).decorate if params[:search]
  end

  def show
    @confession = ::ActivityLines::Corporative::Confession.includes(:member).find(params[:id]).decorate
    @arguments = @confession.arguments.includes(:member).order :member_id, :argument_type
  end

  def new
    @confession_form = ::ActivityLines::Corporative::ConfessionForm.new_with_model
  end

  def create
    @confession_form = ::ActivityLines::Corporative::ConfessionForm.new_with_model
    @confession_form.submit params[:activity_lines_corporative_confession]
    if @confession_form.save
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
    @confession_form.submit params[:activity_lines_corporative_confession]
    if @confession_form.save
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
end
