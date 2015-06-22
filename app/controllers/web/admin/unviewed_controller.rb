class Web::Admin::UnviewedController < Web::Admin::ApplicationController
  def index
    @unviewed = {}
    @unviewed[:members] = Kaminari.paginate_array(Member.unviewed.decorate).page params[:page]
    @unviewed[:questionaries] = Kaminari.paginate_array(Questionary.unviewed.decorate).page params[:page]
    @unviewed[:users] = Kaminari.paginate_array(User.unviewed.decorate).page params[:page]
    @unviewed[:news] = Kaminari.paginate_array(News.unviewed.decorate).page params[:page]
    @unviewed[:events] = Kaminari.paginate_array(Event.unviewed.decorate).page params[:page]
    @unviewed[:feedback] = Kaminari.paginate_array(Feedback.unviewed.decorate).page params[:page]
    @tag = Tag.new
  end
end
