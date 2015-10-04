class UserMailerPreview < ActionMailer::Preview
  def after_create
    UserMailer.after_create(User.first, User.first)
  end
end
