class Projects::ItWay::V2017::ParticipantForm < Projects::ApplicationRecordForm
  attr_accessor :first_name,
                :last_name,
                :patronymic,
                :activity_line,
                :email,
                :phone,
                :region,
                :locality,
                :experience,
                :reason,
                :has_i_note,
                :school,
                :group,
                :birth_date,
                :year

  ACTIVITY_LINES = [ :programming, :design, :steel ]

  def title
    "#{record.properties["last_name"]} #{record.properties["first_name"]} #{record.properties["patronymic"]}"
  end

  def project_id
    1
  end

  def version
    2017
  end

  def record_type
    :participant
  end
end
