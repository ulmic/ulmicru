class Web::Admin::ActivityLines::Corporative::ConfessionsController < Web::Admin::ActivityLines::Corporative::ApplicationController
  def index
    @confessions = {}
    @confessions[:confirmed] =ActivityLines::Corporative::Confession.confirmed.page(params[:page]).decorate
    @confessions[:unviewed] = ActivityLines::Corporative::Confession.unviewed.page(params[:page]).decorate
    @confessions[:on_vote] = ActivityLines::Corporative::Confession.on_vote.page(params[:page]).decorate
    @confessions[:declined] = ActivityLines::Corporative::Confession.declined.page(params[:page]).decorate
    @confessions[:search] = ActivityLines::Corporative::Confession.search_everywhere(params[:search]).page(params[:page]).decorate if params[:search]
  end

  def new
    @confession_form = ActivityLines::Corporative::ConfessionForm.new_with_model
  end

  def create
    @confession_form = ActivityLines::Corporative::ConfessionForm.new_with_model

    params[:confession][:user_id] = current_user.id if current_user.present?
    @confession_form.submit params[:confession]
    if @confession_form.save
      redirect_to admin_confessions_path
    else
      @categories = Category.presented.decorate
      render action: :new
    end
  end

  def edit
    @confession_form = ActivityLines::Corporative::ConfessionForm.find_with_model params[:id]
  end

  def update
    @confession_form = ActivityLines::Corporative::ConfessionForm.find_with_model params[:id]
    @confession_form.submit params[:confession]
    if @confession_form.save
      redirect_to edit_admin_confession_path @confession_form.model
    else
      render action: :edit
    end
  end

  def destroy
    @confession = ActivityLines::Corporative::Confession.find params[:id]
    @confession.remove
    redirect_to admin_confessions_path
  end
end
