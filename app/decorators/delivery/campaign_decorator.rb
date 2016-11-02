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

  def view_attributes
    attrs = [:title, :body, :image_tag, :link_to, :creator_link, :mailing_date, :created_at, :updated_at,
     :state, :letters_count]
    attrs.reduce({}) do |hash, attr|
      hash.merge! attr => send(attr)
    end
  end

  def image_tag
    h.image_tag image
  end

  def link_to
    h.link_to link, link
  end

  def creator_link
    h.link_to object.creator.decorate.short_name, admin_member_path(object.creator)
  end

  def letters_count
    object.contacts.count
  end
end
