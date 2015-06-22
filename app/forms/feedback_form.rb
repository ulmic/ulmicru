class FeedbackForm < ApplicationForm
  self.main_model = :feedback

  attributes :text, :url, :user_id
end
