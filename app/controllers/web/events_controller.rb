class Web::EventsController < Web::ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = ::Event.includes(:online_conference).find(params[:id]).decorate
    organizers = @event.registrations.organizers
    attenders = @event.registrations.attenders
    @all_registrations = Event::RegistrationDecorator.decorate_collection(organizers + attenders)
    @registrations = @all_registrations.first 10
    @other_registrations = @all_registrations.drop 10
    if @event.is_online_conference?
      @questions = ::ActivityLines::Corporative::OnlineConference::Question.active
      @question_form = ::ActivityLines::Corporative::OnlineConference::QuestionForm.new_with_model
    end
  end
end
