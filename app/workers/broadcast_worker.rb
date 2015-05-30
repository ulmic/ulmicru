# -*- coding: utf-8 -*-
class BroadcastWorker
  include ApplicationWorker
  # sidekiq_options retry: false

  def perform(ids, message, subject)
    users = User.where(id: ids)
    users.each_with_index do |user, index|
      time = (index * 5).second
      UserMailer.delay_for(time).just_message(user, message, subject)
    end
  end
end
