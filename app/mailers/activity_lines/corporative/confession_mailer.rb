class ActivityLines::Corporative::ConfessionMailer < ApplicationMailer
  default template_path: "mailers/#{self.name.underscore}"

  def create(confession, user)
    @user = user
    @member = confession.member.decorate
    @subject = subject(confession.class, :create)
    mail from: sender_name, to: user.email, subject: @subject
  end

  def confirm(confession, user)
    @user = user
    @confession = confession
    @subject = subject(confession.class, :confirm)
    mail from: sender_name, to: user.email, subject: @subject
  end

  def nominated(confession, user)
    @user = user
    @confession = confession
    @subject = subject(confession.class, :nominated)
    mail from: sender_name, to: user.email, subject: @subject
  end
end
