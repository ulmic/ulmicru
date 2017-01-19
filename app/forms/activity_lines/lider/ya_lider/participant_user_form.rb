class ActivityLines::Lider::YaLider::ParticipantUserForm < Reform::Form
  properties :email, :first_name, :last_name, :patronymic, :birth_date, :municipality, :locality, :school, :mobile_phone

  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :patronymic, presence: true
  validates :birth_date, presence: true
  validates :municipality, presence: true
  validates :locality, presence: true
  validates :school, presence: true
  validates :mobile_phone, presence: true

  def submit(params)
    raise 'ApplicationForm::Params should not be nil' unless params
    save if validate params
  end
end
