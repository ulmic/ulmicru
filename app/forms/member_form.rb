class MemberForm < ActiveForm::Base
  self.main_model = :member

  attributes :first_name, :last_name, :patronymic, :email, :user_id, :motto, :ticket, :parent_id, :mobile_phone, :birth_date, :home_adress, :municipality, :locality, :avatar
end
