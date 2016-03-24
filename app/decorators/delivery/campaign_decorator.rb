class Delivery::CampaignDecorator < ApplicationDecorator
  delegate_all

  decorates_association :creator

  def lead
    "#{model.body.first(200)}..."
  end

  def contacts
    contacts = []
    object.audiences.each do |audience|
      contacts += audience.decorate.contacts
    end
    contacts
  end

  def self.collections
    [ :ready, :done, :removed, :declined ]
  end
end
