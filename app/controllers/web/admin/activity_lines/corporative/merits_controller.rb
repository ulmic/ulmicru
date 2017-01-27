class Web::Admin::ActivityLines::Corporative::MeritsController <
      Web::Admin::ActivityLines::Corporative::ApplicationController
  before_filter :choose_users, only: [ :new, :edit ]

  def index
    if params[:search]
      merits = ::ActivityLines::Corporative::Merit.active.search_everywhere params[:search]
    else
      merits = ::ActivityLines::Corporative::Merit.send params[:scope]
    end
    @activity_lines_corporative_merits = merits.page(params[:page]).decorate
  end

  def show
    @merit = ::ActivityLines::Corporative::Merit.find(params[:id]).decorate
  end

  def new
    @merit_form = ::ActivityLines::Corporative::MeritForm.new_with_model
  end

  def edit
    @merit_form = ::ActivityLines::Corporative::MeritForm.find_with_model params[:id]
  end

  def create
    @merit_form = ::ActivityLines::Corporative::MeritForm.new_with_model
    if @merit_form.submit params[:activity_lines_corporative_merit]
      redirect_to admin_activity_lines_corporative_merits_path
    else
      choose_users
      render action: :new
    end
  end

  def update
    @merit_form = ::ActivityLines::Corporative::MeritForm.find_with_model params[:id]
    if @merit_form.submit params[:activity_lines_corporative_merit]
      redirect_to admin_activity_lines_corporative_merit_path @merit_form.model
    else
      choose_users
      render action: :edit
    end
  end

  def destroy
    @merit = ::ActivityLines::Corporative::Merit.find params[:id]
    @merit.remove
    redirect_to admin_activity_lines_corporative_merits_path
  end

  private

  def create_tag
    Tag.create record_type: 'Article',
               record_id: configus.activity_lines.corporative.merit.article_id,
               tag_type: :link,
               target_type: 'Member',
               target_id: params[:activity_lines_corporative_merit][:user_id]
  end
end
