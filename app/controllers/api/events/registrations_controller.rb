class Api::Events::RegistrationsController < Api::Events::ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_confirmed_user!

  def create
    @event_form = Event::RegistrationForm.new_with_model
    if params[:event_registration][:user_id] == current_user.id.to_s
      @event_form.submit params[:event_registration]
      if @event_form.save
        render json: { role: @event_form.model.role, participant: @event_form.model.user.to_json(only: [:id, :ticket, :first_name, :last_name, :short_name, :avatar]) }
      else
        head :bad_request
      end
    else
      head :unprocessable_entity
    end
  end

  def destroy
    if params[:user_id] == current_user.id.to_s
      @event_registration = Event::Registration.where(event_id: params[:event_id], user_id: params[:user_id]).first
      user_id = @event_registration.user_id
      @event_registration.destroy
      render json: user_id
    else
      head :unprocessable_entity
    end
  end
end
