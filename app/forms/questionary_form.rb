class QuestionaryForm < ApplicationForm
  attributes :first_name, :last_name, :patronymic, :email, :motto, :mobile_phone, :birth_date, :home_adress, :municipality, :locality, :avatar, :state, :experience, :want_to_do, :source_to_know, :email_state, required: true
  attributes :request_date, :corporate_email

  association :positions do
    attributes :title, :begin_date, :member_id, :state, :end_date, :for_now, :status
  end
end
