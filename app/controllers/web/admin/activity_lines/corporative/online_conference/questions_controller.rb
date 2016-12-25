class Web::Admin::ActivityLines::Corporative::OnlineConference::QuestionsController < 
      Web::Admin::ActivityLines::Corporative::ApplicationController

  def edit
    @question_form = ::ActivityLines::Corporative::OnlineConference::QuestionForm.find_with_model params[:id]
  end

  def update
    @question = ::ActivityLines::Corporative::OnlineConference::QuestionForm.find_with_model params[:id]
    if @question.submit params[:activity_lines_corporative_online_conference_question]
      send_notification @question.user, @question.model, :confirm if question_confirmed? && @question.user_id.present?
      send_notification @question.user, @question.model, :answer if question_answered? && @question.user_id.present?
      Organization::Permissions.activity_lines_corporative_online_conference_question[:review].each do |member|
        send_notification member, @question.model, :text_update if question_text_updated?
      end
      redirect_to :back
    end
  end

  def destroy
    question = ::ActivityLines::Corporative::OnlineConference::Question.find params[:id]
    question.remove
    redirect_to admin_activity_lines_corporative_online_conference_path question.online_conference
  end

  private

  def question_confirmed?
    params[:activity_lines_corporative_online_conference_question][:state] == 'active' && @prev_object_attributes[:state] != 'active'
  end

  def question_answered?
    params[:activity_lines_corporative_online_conference_question][:answer_timestamp].present? && @prev_object_attributes[:answer_timestamp].nil?
  end

  def question_text_updated?
    params[:activity_lines_corporative_online_conference_question][:text] != @prev_object_attributes[:text]
  end
end
