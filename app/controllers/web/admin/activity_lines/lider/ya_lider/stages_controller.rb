class Web::Admin::ActivityLines::Lider::YaLider::StagesController < Web::Admin::ActivityLines::ApplicationController
  def show
    @stage = ActivityLines::Lider::YaLider::Stage.find(params[:id]).decorate
    @current_participants = @stage.current_participants
  end

  def new
    @stage_form = ::ActivityLines::Lider::YaLider::StageForm.new_with_model
  end

  def create
    @stage_form = ::ActivityLines::Lider::YaLider::StageForm.new_with_model
    if @stage_form.submit params[:activity_lines_lider_ya_lider_stage]
      redirect_to admin_activity_lines_lider_ya_lider_path @stage_form.model.ya_lider
    else
      render action: :new
    end
  end

  def edit
    @stage_form = ::ActivityLines::Lider::YaLider::StageForm.find_with_model params[:id]
  end

  def update
    @stage_form = ::ActivityLines::Lider::YaLider::StageForm.find_with_model params[:id]
    if @stage_form.submit params[:activity_lines_lider_ya_lider_stage]
      redirect_to admin_activity_lines_lider_ya_lider_path @stage_form.model.contest
    else
      render action: :edit
    end
  end

  def destroy
    @stage = ::ActivityLines::Lider::YaLider::Stage.find params[:id]
    @stage.remove
    redirect_to admin_activity_lines_lider_ya_lider_path @stage.ya_lider
  end
end
