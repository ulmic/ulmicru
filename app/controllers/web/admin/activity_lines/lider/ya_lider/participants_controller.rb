class Web::Admin::ActivityLines::Lider::YaLider::ParticipantsController < ApplicationController
  def new
    @participant_form = ::ActivityLines::Lider::YaLider::ParticipantForm.new_with_model
  end

  def create
    @participant_form = ::ActivityLines::Lider::YaLider::ParticipantForm.new_with_model
    if @participant_form.submit params[:activity_lines_lider_ya_lider_participant]
      redirect_to admin_activity_lines_lider_ya_lider_path @participant_form.model.ya_lider
    else
      render action: :new
    end
  end

  def edit
    @participant_form = ::ActivityLines::Lider::YaLider::ParticipantForm.find_with_model params[:id]
  end

  def update
    @participant_form = ::ActivityLines::Lider::YaLider::ParticipantForm.find_with_model params[:id]
    if @participant_form.submit params[:activity_lines_lider_ya_lider_participant]
      redirect_to admin_activity_lines_lider_ya_lider_path @participant_form.model.ya_lider
    else
      render action: :edit
    end
  end

  def destroy
    @participant = ::ActivityLines::Lider::YaLider::Participant.find params[:id]
    @participant.remove
    redirect_to admin_activity_lines_lider_ya_lider_path @participant.ya_lider
  end
end
