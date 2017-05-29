class Web::Admin::Delivery::CampaignsController < Web::Admin::Delivery::ApplicationController
  def index
    if params[:search]
      campaigns = ::Delivery::Campaign.search_everywhere params[:search]
    else
      campaigns = ::Delivery::Campaign.send params[:scope]
    end
    @campaigns = campaigns.page(params[:page]).decorate
  end

  def new
    @campaign_form = ::Delivery::CampaignForm.new_with_model
  end

  def edit
    @campaign_form = ::Delivery::CampaignForm.find_with_model params[:id]
  end

  def show
    @campaign = ::Delivery::Campaign.includes(:audiences, :receivers).find(params[:id]).decorate
    @audience_form = ::Delivery::AudienceForm.new_with_model
  end

  def create
    params[:delivery_campaign].merge! creator_id: current_user.id
    @campaign_form = ::Delivery::CampaignForm.new_with_model
    @campaign_form.submit params[:delivery_campaign]
    if @campaign_form.save
      ::Admin::FillReceiversJob.perform_later @campaign_form.model
      redirect_to admin_delivery_campaign_path(@campaign_form.model)
    else
      render action: :new
    end
  end

  def update
    params[:delivery_campaign].merge! creator_id: current_user.id
    @campaign_form = ::Delivery::CampaignForm.find_with_model params[:id]
    @campaign_form.submit params[:delivery_campaign]
    if @campaign_form.save
      ::Admin::FillReceiversJob.perform_later @campaign_form.model
      redirect_to admin_delivery_campaign_path(@campaign_form.model)
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
