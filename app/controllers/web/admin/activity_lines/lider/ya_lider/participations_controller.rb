class Web::Admin::ActivityLines::Lider::YaLider::ParticipationsController < Web::Admin::ActivityLines::Lider::YaLider::ApplicationController
  before_filter :choose_users, only: [ :new, :edit ]

  def new
    @participation_form = ::ActivityLines::Lider::YaLider::ParticipationForm.new_with_model
  end

  def create
    @participation_form = ::ActivityLines::Lider::YaLider::ParticipationForm.new_with_model
    if @participation_form.submit params[:activity_lines_lider_ya_lider_participation]
      redirect_to admin_activity_lines_lider_ya_lider_stage_path @participation_form.model.stage
    else
      choose_users
      render action: :new
    end
  end

  def edit
    @participation_form = ::ActivityLines::Lider::YaLider::ParticipationForm.find_with_model params[:id]
  end

  def update
    @participation_form = ::ActivityLines::Lider::YaLider::ParticipationForm.find_with_model params[:id]
    if @participation_form.submit params[:activity_lines_lider_ya_lider_participation]
      redirect_to admin_activity_lines_lider_ya_lider_path @participation_form.model.ya_lider
    else
      choose_users
      render action: :edit
    end
  end

  def destroy
    @participation = ::ActivityLines::Lider::YaLider::Participation.find params[:id]
    @participation.remove
    redirect_to admin_activity_lines_lider_ya_lider_path @participation.ya_lider
  end
end
