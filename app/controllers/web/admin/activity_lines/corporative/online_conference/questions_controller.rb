class Web::Admin::ActivityLines::Corporative::OnlineConference::QuestionsController < 
      Web::Admin::ActivityLines::Corporative::ApplicationController

  def edit
    @question_form = ::ActivityLines::Corporative::OnlineConference::QuestionForm.find_with_model params[:id]
    if @question_form.model.answer_timestamp.present?
      redirect_to admin_activity_lines_corporative_online_conference_path @question_form.online_conference
    end
  end

  def update
    @question = ::ActivityLines::Corporative::OnlineConference::QuestionForm.find_with_model params[:id]
    if @question.submit params[:activity_lines_corporative_online_conference_question]
      send_notification @question.user, @question.model, :confirm if question_confirmed? && question.user_id.present?
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
end
