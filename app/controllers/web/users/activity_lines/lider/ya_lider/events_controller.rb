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
end
