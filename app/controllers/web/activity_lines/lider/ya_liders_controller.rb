class Web::ActivityLines::Lider::YaLidersController < Web::ActivityLines::Lider::ApplicationController
  def show
    @ya_lider = ::ActivityLines::Lider::YaLider.where number: params[:id]
  end
end
