class QuestionaryForm < ApplicationForm
  self.main_model = :questionary

  attributes :first_name, :last_name, :patronymic, :email, :motto, :mobile_phone, :birth_date, :home_adress, :municipality, :locality, :avatar, :state, :experience, :want_to_do, required: true
end
