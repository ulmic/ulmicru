class Web::Users::ActivityLines::Lider::YaLider::EventsController < Web::Users::ActivityLines::Lider::YaLider::ApplicationController
  def new
    @event_form = ::ActivityLines::Lider::YaLider::EventForm.new_with_model
    @event_form.build_values!
  end
end
