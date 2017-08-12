class Projects::ItWay::V2017::ParticipantForm < Projects::ApplicationRecordForm
  delegate :title, to: :record

  def first_name
  end

  def first_name=(value)
    properties ||= {}
    properties.merge! first_name: value
  end

  def last_name
  end

  def patronymic
  end

  def activity_line
  end

  def email
  end

  def phone
  end

  def region
  end

  def locality
  end

  def experience
  end

  def reason
  end

  def has_i_note
  end

  def school
  end

  def group
  end

  def birth_date
  end

  def year
  end
end
