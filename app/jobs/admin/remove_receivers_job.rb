class Admin::RemoveReceiversJob < ActiveJob::Base
  queue_as :default

  def perform(campaign)
    campaign.remove_receivers!
  end
end
