class Api::Events::RegistrationsController < Api::Events::ApplicationController
  def create
    @event_form = EventForm.new_with_model
    @event_form.submit params[:event]
    if @event_form.save
      head :ok
    else
      head :bad_request
    end
  end

  def destroy
    @event = Event.find params[:id]
    @event.remove
    head :ok
  end
end
