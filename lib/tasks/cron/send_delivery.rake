namespace :delivery do
  desc 'Send delivery'
  task send: :environment do
    ::Delivery::Receiver.includes(:campaign).order(id: :asc).where(state: :ready).limit(100).each_with_index do |receiver|
        UserMailer.delay.just_message receiver.user.decorate,
          receiver.user.email,
          receiver.campaign.title,
          receiver.campaign.body,
          receiver.campaign.link,
          receiver.campaign.image.url,
          receiver.user.subscribe_token
        receiver.send_email
        print "Campaign #{receiver.campaign.id} receiver #{receiver.id} have sent\r"
    end
    Delivery::Campaign.where(state: :during_mailing).each do |campaign|
      if campaign.receivers.map(&:state).uniq == ['sent']
        campaign.make_done
        puts "Campaign #{campaign.title} is done!".green
      end
    end
  end
end
