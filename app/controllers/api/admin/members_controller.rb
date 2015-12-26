class Api::Admin::MembersController < Api::Admin::ApplicationController
  AVAILABLE_CONDITIONS = [ 'without_debut', 'without_number_one' ]

  def index
    if params[:q].present?
      @members = Member.search_everywhere params[:q][:term]
    else
      @members = Member.tag_available
    end
    if params[:condition].present? && params[:condition].in?(AVAILABLE_CONDITIONS)
      conditional_members = Member.send params[:condition]
      @members = @members & conditional_members
    end
    render json: @members.to_json(only: [:id, :ticket, :first_name, :last_name])
  end
end
