class UserMailerPreview < ActionMailer::Preview
  def after_create
    UserMailer.after_create User.last, User.last
  end
end
