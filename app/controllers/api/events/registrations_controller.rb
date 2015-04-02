class Api::Events::RegistrationsController < Api::Events::ApplicationController
  def create
    @event_form = Event::RegistrationForm.new_with_model
    @event_form.submit params[:event_registration]
    if @event_form.save
      head :ok
    else
      head :bad_request
    end
  end

  def destroy
    @event_registration = Event::Registration.where(event_id: params[:event_id], user_id: params[:user_id]).first
    @event_registration.destroy
    head :ok
  end
end
