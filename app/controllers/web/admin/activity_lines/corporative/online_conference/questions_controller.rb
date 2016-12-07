class Web::Admin::ActivityLines::Corporative::OnlineConference::QuestionsController < 
      Web::Admin::ActivityLines::Corporative::ApplicationController

  def update
    @question = ::ActivityLines::Corporative::OnlineConference::QuestionForm.find_with_model params[:id]
    if @question.submit params[:activity_lines_corporative_online_conference_question]
      redirect_to admin_unviewed_index_path items: 'activity_lines/corporative/online_conference/question'
    end
  end

  def destroy
    question = ::ActivityLines::Corporative::OnlineConference::Question.find params[:id]
    question.remove
    redirect_to admin_activity_lines_corporative_online_conference_path question.online_conference
  end
end
