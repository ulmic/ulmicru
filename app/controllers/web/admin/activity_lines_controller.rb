class Web::Admin::ActivityLinesController < Web::Admin::ApplicationController
  before_filter :choose_members, only: [ :new, :edit ]

  def index
    @activity_lines = {}
    @activity_lines[:active] = Kaminari.paginate_array(ActivityLine.active.decorate).page params[:page]
    @activity_lines[:unviewed] = Kaminari.paginate_array(ActivityLine.unviewed.decorate).page params[:page]
    @activity_lines[:removed] = Kaminari.paginate_array(ActivityLine.removed.decorate).page params[:page]
    @activity_lines[:search] = Kaminari.paginate_array(ActivityLine.search_everywhere(params[:search]).decorate).page(params[:page]) if params[:search]
  end

  def new
    @activity_line_form = ActivityLineForm.new_with_model
  end

  def edit
    @activity_line_form = ActivityLineForm.find_with_model params[:id]
  end

  def create
    @activity_line_form = ActivityLineForm.new_with_model
    @activity_line_form.submit(params[:activity_line])
    if @activity_line_form.save
      redirect_to admin_activity_lines_path
    else
      choose_members
      render action: :new
    end
  end

  def update
    @activity_line_form = ActivityLineForm.find_with_model params[:id]
    @activity_line_form.submit(params[:activity_line])
    if @activity_line_form.save
      redirect_to edit_admin_activity_line_path @activity_line_form.model
    else
      choose_members
      render action: :edit
    end
  end

  def destroy
    @activity_line = ActivityLine.find params[:id]
    @activity_line.remove
    redirect_to admin_activity_lines_path
  end
end
