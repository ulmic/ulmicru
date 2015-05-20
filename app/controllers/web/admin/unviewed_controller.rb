class Web::Admin::UnviewedController < Web::Admin::ApplicationController
  def index
    @members = Member.unviewed.decorate
    @questionaries = Questionary.unviewed.decorate
    @users = User.unviewed.decorate
    @news = News.unviewed.decorate
    @events = Event.unviewed.decorate
  end
end
