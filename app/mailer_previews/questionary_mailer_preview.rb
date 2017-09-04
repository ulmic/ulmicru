class QuestionaryMailerPreview
  def create
    QuestionaryMailer.create questionary, user
  end
end
