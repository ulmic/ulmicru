class Delivery::CampaignDecorator < ApplicationDecorator
  delegate_all

  decorates_association :creator

  def lead
    "#{model.body.first(200)}..."
  end

  def self.collections
    [ :ready, :done, :removed, :during_mailing, :declined ]
  end

  def name
    model.title
  end
end
