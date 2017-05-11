class Web::Admin::MinesController < Web::Admin::ApplicationController
  def show
    params[:tab] ||= 'event'
    case params[:tab]
    when 'event'
      @items = ::Event.where(creator_id: current_user.id).order(id: :desc).page(params[:page]).decorate
    when 'news'
      @items = News.where(user_id: current_user.id).order(id: :desc).page(params[:page]).decorate
    end
  end
end
