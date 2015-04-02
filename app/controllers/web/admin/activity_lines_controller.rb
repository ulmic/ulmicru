class Web::Admin::ActivityLinesController < Web::Admin::ApplicationController
  def index
    @activity_lines = ActivityLine.all.decorate
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
      render action: :new
    end
  end

  def update
    @activity_line_form = ActivityLineForm.find_with_model params[:id]
    @activity_line_form.submit(params[:activity_line])
    if @activity_line_form.save
      redirect_to admin_activity_lines_path
    else
      render action: :edit
    end
  end

  def destroy
    @activity_line = ActivityLine.find params[:id]
    @activity_line.remove
    redirect_to admin_activity_lines_path
  end
end
