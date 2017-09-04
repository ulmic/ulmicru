class EventMailerPreview
  def update
    EventMailer.update event, user
  end
end
