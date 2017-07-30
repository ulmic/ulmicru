class Web::EventsController < Web::ApplicationController
  def index
    @events = ::EventDecorator.decorate_collection ::Event.includes(:activity_line, :organizer).confirmed.near_future.first 24
  end

  def show
    @event = ::Event.includes(:online_conference).find(params[:id]).decorate
    View.create! user_id: current_user&.id, record_id: @event.id, record_type: 'Event'
    organizers = @event.registrations.organizers
    attenders = @event.registrations.attenders
    @all_registrations = Event::RegistrationDecorator.decorate_collection(organizers + attenders)
    @registrations = @all_registrations.first 10
    @other_registrations = @all_registrations.drop 10
    if @event.is_online_conference?
      @question_form = ::ActivityLines::Corporative::OnlineConference::QuestionForm.new_with_model
      @confirmed_questions = @event.online_conference.questions.active
    end
  end
end
