class Api::Members::Corporative::ArgumentsController < Api::Members::Corporative::ApplicationController
  def create
    params[:arguments].each do |index, argument_params|
      attrs = argument_params.merge({ member_id: current_user.id })
      a = ::ActivityLines::Corporative::ArgumentForm.new_with_model
      a.submit attrs
    end
    head :ok
  end
end
