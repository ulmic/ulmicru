class Delivery::CampaignDecorator < ApplicationDecorator
  delegate_all

  decorates_association :creator

  def lead
    "#{model.body.first(200)}..."
  end

  def emails
  end
end
