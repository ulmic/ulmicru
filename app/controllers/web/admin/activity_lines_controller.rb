class Web::Admin::ActivityLinesController < Web::Admin::ApplicationController
  def index
    @activity_lines = ActivityLine.all
  end

  def new
    @activity_line = ActivityLine.new
    @activity_line_form = ActivityLineForm.new(@activity_line)
  end

  def edit
    @activity_line = ActivityLine.find params[:id]
    @activity_line_form = ActivityLineForm.new(@activity_line)
  end

  def create
    @activity_line = ActivityLine.new
    @activity_line_form = ActivityLineForm.new(@activity_line)
    @activity_line_form.submit(params[:activity_line])
    if @activity_line_form.save
      redirect_to admin_activity_lines_path
    else
      render action: :new
    end
  end

  def update
    @activity_line = ActivityLine.find params[:id]
    @activity_line_form = ActivityLineForm.new(@activity_line)
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
