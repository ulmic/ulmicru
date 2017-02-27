class Web::PagesController < Web::ApplicationController
  def show
    @page = Page.find_by_slug params[:slug]
    if @page.layout.none?
      render layout: false
    end
  end
end
