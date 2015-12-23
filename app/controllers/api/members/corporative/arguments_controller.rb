class Api::Members::Corporative::ArgumentsController < Api::Members::Corporative::ApplicationController
  def create
    ::ActivityLines::Corporative::Argument.create! params[:arguments]
    head :ok
  end
end
