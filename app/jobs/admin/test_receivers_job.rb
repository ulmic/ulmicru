class Admin::TestReceiversJob < ActiveJob::Base
  queue_as :default

  def perform(contacts, title, text, link, image, campaign_id)
    campaign = ::Delivery::Campaign.find(campaign_id)
    contacts.each do |receiver|
      begin
        UserMailerPreview.new.just_message receiver.user, title, text, link, image, receiver.user.subscribe_token.content
      rescue
        campaign.fail_test
      end
      if campaign.not_tested?
        campaign.get_ready
      end
    end
  end
end
