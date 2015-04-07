class Api::Admin::MembersController < Api::Admin::ApplicationController
  def index
    @members = Member.confirmed.decorate
    render json: @members.to_json(only: [:id, :ticket, :first_name, :last_name])
  end
end
