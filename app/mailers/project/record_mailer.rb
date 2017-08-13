class Project::RecordMailer < ApplicationMailer
  default template_path: "mailers/#{self.name.underscore}"

  def create(record, user)
    @user = user
    @record = record
    mail from: sender_name, to: user.email, subject: (subject(record.class, :create) + record.version)
  end
end
