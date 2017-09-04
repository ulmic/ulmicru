class ContactEmailMailerPreview
  def create
    ContactEmailMailer.create contact_email
  end
end
