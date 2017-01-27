class Api::ActivityLines::Lider::YaLider::ParticipantsController < Api::ActivityLines::Lider::YaLider::ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def create
    params[:user] = JSON.parse params[:_json]
    params[:user][:birth_date] = DateTime.strptime params[:user][:birth_date].to_s, '%s'
    user = User.confirmed.where(email: params[:user][:email]).first
    if user
      user_form = UserForm.new user
      params[:user].each do |attr, value|
        if user.try(attr).nil?
          user_form.submit attr => value 
        end
      end
      create_participant user
    else
      user_form = ActivityLines::Lider::YaLider::ParticipantUserForm.new User.new
      if user_form.submit params[:user]
        create_participant user_form, avatar_update: true
      else
        User.tech_admins.each do |user|
          send_notification user, user_form.model, :fail_participant_api_create
        end
        head :bad_request
      end
    end
  end

  private

  def create_participant(user, avatar_update: false)
    params[:activity_lines_lider_ya_lider_participant] = {}
    params[:activity_lines_lider_ya_lider_participant][:user_id] = user.id
    params[:activity_lines_lider_ya_lider_participant][:contest_id] = ::ActivityLines::Lider::YaLider.current.first.id
    params[:activity_lines_lider_ya_lider_participant][:fields_attributes] = {}
    params[:user][:fields].each do |index, obj|
      params[:activity_lines_lider_ya_lider_participant][:fields_attributes][index] = {
        value: obj[:value],
        title: obj[:title],
        participant_id: obj[:user_id],
        field_type: obj[:field_type]
      }
    end
    participant_form = ::ActivityLines::Lider::YaLider::ParticipantForm.new_with_model
    if participant_form.submit params[:activity_lines_lider_ya_lider_participant]
      first_stage = participant_form.model.contest.first_stage
      ActivityLines::Lider::YaLider::Participation.create! participant_id: participant_form.model.id, stage_id: first_stage.id
      head :ok
      if avatar_update
        user.model.update_attributes! remote_avatar_url: "#{configus.it_projects.ul_lider.url}#{params[:user][:avatar]}"
      end
    else
      User.tech_admins.each do |user|
        send_notification user, participant_form.model, :fail_api_create
      end
      head :bad_request
    end
  end
end
