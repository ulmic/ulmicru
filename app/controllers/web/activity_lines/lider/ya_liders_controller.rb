class Web::ActivityLines::Lider::YaLidersController < Web::ActivityLines::Lider::ApplicationController
  def show
    @contest = ::ActivityLines::Lider::YaLider.where(contest_number: params[:id]).first.decorate
  end
end
