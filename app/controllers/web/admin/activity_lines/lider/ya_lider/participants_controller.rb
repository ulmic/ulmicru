class Web::Admin::ActivityLines::Lider::YaLider::ParticipantsController < Web::Admin::ActivityLines::Lider::YaLider::ApplicationController
  before_filter :choose_users, only: [ :new, :edit ]

  def new
    @participant_form = ::ActivityLines::Lider::YaLider::ParticipantForm.new_with_model
  end

  def create
    @participant_form = ::ActivityLines::Lider::YaLider::ParticipantForm.new_with_model
    if @participant_form.submit params[:activity_lines_lider_ya_lider_participant]
      redirect_to admin_activity_lines_lider_ya_liders_path
    else
      choose_users
      render action: :new
    end
  end

  def edit
    @participant_form = ::ActivityLines::Lider::YaLider::ParticipantForm.find_with_model params[:id]
  end

  def update
    @participant_form = ::ActivityLines::Lider::YaLider::ParticipantForm.find_with_model params[:id]
    if @participant_form.submit params[:activity_lines_lider_ya_lider_participant]
      redirect_to admin_activity_lines_lider_ya_liders_path
    else
      choose_users
      render action: :edit
    end
  end

  def destroy
    @participant = ::ActivityLines::Lider::YaLider::Participant.find params[:id]
    @participant.remove
    redirect_to admin_activity_lines_lider_ya_liders_path
  end
end
