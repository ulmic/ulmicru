class Web::Admin::Delivery::SessionsController < Web::Admin::Delivery::ApplicationController
  def create
    @campaign = Delivery::Campaign.find(params[:id]).decorate
  end

  def destroy
  end
end
