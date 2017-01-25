class Web::Admin::ActivityLines::Lider::YaLider::ParticipantFieldsController < 
      Web::Admin::ActivityLines::Lider::YaLider::ApplicationController
  
  def new
    @participant_field_form = ::ActivityLines::Lider::YaLider::ParticipantFieldForm.new_with_model
  end

  def create
    @participant_field_form = ::ActivityLines::Lider::YaLider::ParticipantFieldForm.new_with_model
    if @participant_field_form.submit params[:activity_lines_lider_ya_lider_participant_field]
      redirect_to admin_activity_lines_lider_ya_lider_participant_path @participant_field_form.model.participant
    else
      render :new
    end
  end
end
