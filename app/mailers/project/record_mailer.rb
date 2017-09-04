class Project::RecordMailer < ApplicationMailer
  default template_path: "mailers/#{self.name.underscore}"

  def create(record, user)
    @user = user
    @record = record
    mail from: sender_name, to: user.email, subject: (subject(record.class, :create, :admin) + record.version.to_s)
  end

  def confirm(user_as_record, user)
    @user = user
    @user_as_record = user_as_record
    mail from: sender_name, to: user.properties[:email], subject: subject(user_as_record.class, :confirm)
  end
end
