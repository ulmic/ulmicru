class Web::Admin::ActivityLines::Lider::YaLider::ParticipantsController < Web::Admin::ActivityLines::Lider::YaLider::ApplicationController
  before_filter :choose_users, only: [ :new, :edit ]

  def index
    participants = if params[:contest_id].present?
                     ActivityLines::Lider::YaLider.find(params[:contest_id]).participants 
                   else
                     ::ActivityLines::Lider::YaLider::Participant.all
                   end
    if params[:search]
      participants = participants.search_everywhere params[:search]
    else
      participants = participants.send params[:scope]
    end
    @participants = participants.page(params[:page]).decorate
  end

  def show
    @participant = ::ActivityLines::Lider::YaLider::Participant.find(params[:id]).decorate
    @stage = if params[:stage]
               @participant.contest.stages.where(number: params[:stage]).first.decorate
             else
               @participant.contest.stages.order(:number).first.decorate
             end
  end

  def new
    @participant_form = ::ActivityLines::Lider::YaLider::ParticipantForm.new_with_model
  end

  def create
    @participant_form = ::ActivityLines::Lider::YaLider::ParticipantForm.new_with_model
    if @participant_form.submit params[:activity_lines_lider_ya_lider_participant]
      first_stage = @participant_form.model.contest.first_stage
      ActivityLines::Lider::YaLider::Participation.create! participant_id: @participant_form.model.id, stage_id: first_stage.id
      redirect_to admin_activity_lines_lider_ya_lider_stage_path first_stage.id
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
