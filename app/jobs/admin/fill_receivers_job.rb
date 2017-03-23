class Admin::FillReceiversJob < ActiveJob::Base
  queue_as :default

  def perform(campaign)
    campaign.fill_receivers!
  end
end
