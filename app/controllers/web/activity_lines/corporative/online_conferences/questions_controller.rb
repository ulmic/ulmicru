class Web::ActivityLines::Corporative::OnlineConferences::QuestionsController < 
      Web::ActivityLines::Corporative::ApplicationController

  before_filter :check_anonym

  def create
    question = ::ActivityLines::Corporative::OnlineConference::QuestionForm.new_with_model
    if question.submit params[:activity_lines_corporative_online_conference_question]
      redirect_to event_path question.online_conference.event, 
        notice: (question.user_id.present? ? :your_question_will_reviewed : :your_question_will_reviewed_anonym)
    else
      redirect_to question.online_conference.event
    end
  end

  private

  def check_anonym
    user_id = params[:activity_lines_corporative_online_conference_question][:user_id]
    params[:activity_lines_corporative_online_conference_question][:user_id] = if user_id == '0'
        current_user.id
      else
        nil
      end
  end
end
