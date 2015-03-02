class MemberForm < ActiveForm::Base
  self.main_model = :member

  attributes :first_name, :last_name, :patronymic, :user_id, :motto, :ticket_number, :parent_id, :mobile_phone, :birth_date, :home_adress, :municipality, :locality, :avatar
end
