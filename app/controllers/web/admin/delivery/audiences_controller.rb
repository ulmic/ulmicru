class Web::Admin::Delivery::AudiencesController < Web::Admin::Delivery::ApplicationController
  def create
    @audience_form = ::Delivery::AudienceForm.new_with_model
    @audience_form.submit params[:delivery_audience]
    if @audience_form.save
      redirect_to admin_delivery_campaign_path(@audience_form.model.campaign)
    else
      render :new
    end
  end

  def destroy
    @audience = ::Delivery::Audience.find params[:id]
    @audience.destroy
    redirect_to admin_delivery_campaign_path @audience.campaign
  end
end
