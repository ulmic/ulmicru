class Delivery::CampaignForm < ApplicationReform
  properties :title, :body, :image, :link, :mailing_date, :creator_id

  collection :audiences, populate_if_empty: Delivery::Audience do
    properties :audience_id, :audience_type, :campaign_id
  end

  def build_audiences
    audiences << model.audiences.build
  end
end
