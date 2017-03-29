class Web::Users::ActivityLines::Lider::YaLider::EventsController < Web::Users::ActivityLines::Lider::YaLider::ApplicationController
  def new
    case params[:step]
    when '1'
      choose_users
      @event_form = ::EventForm.new_with_model
    when '2'
      @event_form = ::ActivityLines::Lider::YaLider::EventForm.new_with_model
      @event_form.build_values!
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
    end
  end
end
