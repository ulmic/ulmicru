class Api::Admin::Event::RegistrationsController < Api::Admin::ApplicationController
  def create
    event_registration = ::Event::Registration.find_or_create_by user_id: params[:event_registration][:user_id],
      event_id: params[:event_registration][:event_id]
    unless event_registration.present?
      ::Event::Registration.create! user_id: params[:event_registration][:user_id], event_id: params[:event_registration][:event_id]
    end
    head :ok
  end
end
