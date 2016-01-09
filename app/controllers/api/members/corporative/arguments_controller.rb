class Api::Members::Corporative::ArgumentsController < Api::Members::Corporative::ApplicationController
  def create
    params[:arguments].each do |index, argument_params|
      attrs = argument_params.merge({ member_id: current_user.id })
      ::ActivityLines::Corporative::ArgumentType.create! attrs
    end
    head :ok
  end
end
