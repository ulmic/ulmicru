class Api::Admin::MembersController < Api::Admin::ApplicationController
  def index
    @members = Member.tag_available
    render json: { model: 'Member', list: @members.to_json(only: [:id, :ticket, :first_name, :last_name]) }
  end
end
