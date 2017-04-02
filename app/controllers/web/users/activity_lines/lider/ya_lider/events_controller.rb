class Web::Users::ActivityLines::Lider::YaLider::EventsController < Web::Users::ActivityLines::Lider::YaLider::ApplicationController
  def new
    case params[:step]
    when '1'
      choose_users
      @event_form = ::EventForm.new_with_model
      @event_form.registrations << ::Event::RegistrationForm.new_with_model(user_id: current_user.id, role: :organizer)
    when '2'
      @yal_event_form = ::ActivityLines::Lider::YaLider::EventForm.new_with_model
      @yal_event_form.build_values! :anounce
    when '3'
      @yal_event_form = ::ActivityLines::Lider::YaLider::EventForm.find_with_model params[:event_id]
      @yal_event_form.build_values! :report
      @event = ::Event.where(id: @yal_event_form.model.event_id).first
    end
  end

  def create
    case params[:step]
    when '1'
      @event_form = ::EventForm.new_with_model
      @event_form.submit params[:event]
      if @event_form.save
        redirect_to new_users_activity_lines_lider_ya_lider_event_path(step: 2, event_id: @event_form.model.id)
      else
        choose_users
        render :new, step: 1
      end
    when '2'
      @yal_event_form = ::ActivityLines::Lider::YaLider::EventForm.new_with_model
      if @yal_event_form.submit params[:activity_lines_lider_ya_lider_event]
        redirect_to new_users_activity_lines_lider_ya_lider_event_path(step: 3, event_id: @yal_event_form.model.id)
      else
        render :new, step: 2
      end
    end
  end

  def update
    @yal_event_form = ::ActivityLines::Lider::YaLider::EventForm.find_with_model params[:id]
    if @yal_event_form.submit params[:activity_lines_lider_ya_lider_event]
      redirect_to event_path @yal_event_form.model.event_id
    else
      render :new, step: 3
    end
  end
end
