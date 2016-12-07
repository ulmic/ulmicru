class Web::ActivityLines::Corporative::OnlineConferences::QuestionsController < 
      Web::ActivityLines::Corporative::ApplicationController

  def create
    question = ::ActivityLines::Corporative::OnlineConference::QuestionForm.new_with_model
    if question.submit params[:activity_lines_corporative_online_conference_question]
      redirect_to question.online_conference.event
    else
      redirect_to question.online_conference.event
    end
  end
end
