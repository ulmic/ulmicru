class Web::Admin::UnviewedController < Web::Admin::ApplicationController
  def index
    @members = Kaminari.paginate_array(Member.unviewed.decorate).page params[:page]
    @questionaries = Kaminari.paginate_array(Questionary.unviewed.decorate).page params[:page]
    @users = Kaminari.paginate_array(User.unviewed.decorate).page params[:page]
    @news = Kaminari.paginate_array(News.unviewed.decorate).page params[:page]
    @events = Kaminari.paginate_array(Event.unviewed.decorate).page params[:page]
  end
end
