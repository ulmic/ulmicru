class NewsMailerPreview
  def create
    NewsMailer.create news, user
  end
end
