class Web::Admin::Delivery::CampaignsController < Web::Admin::Delivery::ApplicationController
  def index
    @campaigns = {}
    @campaigns[:ready] = ::Delivery::Campaign.ready.page(params[:page]).decorate
    @campaigns[:done] = ::Delivery::Campaign.done.page(params[:page]).decorate
    @campaigns[:removed] = ::Delivery::Campaign.removed.page(params[:page]).decorate
    @campaigns[:declined] = ::Delivery::Campaign.declined.page(params[:page]).decorate
    @campaigns[:search] = ::Delivery::Campaign.search_everywhere(params[:search]).page(params[:page]).decorate if params[:search]
  end

  def new
    @campaign_form = ::Delivery::CampaignForm.new_with_model
  end

  def edit
    @campaign_form = ::Delivery::CampaignForm.find_with_model params[:id]
  end

  def create
    params[:delivery_campaign].merge! creator_id: current_user.id
    @campaign_form = ::Delivery::CampaignForm.new_with_model
    @campaign_form.submit params[:delivery_campaign]
    if @campaign_form.save
      redirect_to admin_delivery_campaigns_path
    else
      render action: :new
    end
  end

  def update
    params[:delivery_campaign].merge! creator_id: current_user.id
    @campaign_form = ::Delivery::CampaignForm.find_with_model params[:id]
    @campaign_form.submit params[:delivery_campaign]
    if @campaign_form.save
      redirect_to edit_admin_delivery_campaign_path @campaign_form
    else
      render action: :edit
    end
  end

  def destroy
    @campaign = ::Delivery::Campaign.find params[:id]
    @campaign.remove
    redirect_to admin_delivery_campaigns_path
  end
end
