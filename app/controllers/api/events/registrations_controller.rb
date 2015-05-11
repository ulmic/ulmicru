class Api::Events::RegistrationsController < Api::Events::ApplicationController
  def create
    @event_form = Event::RegistrationForm.new_with_model
    @event_form.submit params[:event_registration]
    if @event_form.save
      render json: { role: @event_form.model.role, participant: @event_form.model.user.to_json(only: [:id, :ticket, :first_name, :last_name, :short_name, :avatar]) }
    else
      head :bad_request
    end
  end

  def destroy
    @event_registration = Event::Registration.where(event_id: params[:event_id], user_id: params[:user_id]).first
    user_id = @event_registration.user_id
    @event_registration.destroy
    render json: user_id
  end
end
