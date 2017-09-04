class FeedbackMailerPreview
  def finish
    FeedbackMailer.finish feedback, user
  end
end
