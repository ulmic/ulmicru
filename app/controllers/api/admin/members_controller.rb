class Api::Admin::MembersController < Api::Admin::ApplicationController
  def index
    if params[:q].present?
      @members = Member.search_everywhere params[:q][:term]
    else
      @members = Member.tag_available
    end
    render json: @members.to_json(only: [:id, :ticket, :first_name, :last_name])
  end
end
