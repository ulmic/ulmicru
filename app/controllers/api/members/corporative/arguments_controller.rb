class Api::Members::Corporative::ArgumentsController < Api::Members::Corporative::ApplicationController
  def create
    update_params
    params[:arguments].keys.each do |index|
      ::ActivityLines::Corporative::ArgumentType.create! params[:arguments][index]
    end
    head :ok
  end

  private

  def update_params
    params[:arguments].keys.each do |index|
      params[:arguments][index][:member_id] = current_user.id
    end
  end
end
