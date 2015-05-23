class Web::PagesController < Web::ApplicationController
  def show
    @page = Page.find_by_slug params[:slug]
  end
end
