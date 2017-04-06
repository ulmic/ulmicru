class CommentMailer < ApplicationMailer
  default template_path: "mailers/#{self.name.underscore}"

  def create(comment, user)
    @user = user
    @comment = comment
    mail from: sender_name, to: user.email, subject: subject(comment.class, :create)
  end
end
