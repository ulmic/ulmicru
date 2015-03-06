class QuestionaryForm < ActiveForm::Base
  self.main_model = :questionary

  attributes :first_name, :last_name, :patronymic, :email, :user_id, :motto, :ticket, :parent_id, :mobile_phone, :birth_date, :home_adress, :municipality, :locality, :avatar, :state, :experience, :member_id, :want_to_do
end
