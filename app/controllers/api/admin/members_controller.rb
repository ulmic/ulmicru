class Api::Admin::MembersController < Api::Admin::ApplicationController
  def index
    @members = Member.confirmed
    render json: @members
  end
end
