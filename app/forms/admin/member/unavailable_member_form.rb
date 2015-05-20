class Admin::Member::UnavailableMemberForm < ActiveForm::Base
  self.main_model = :member

  attributes :first_name, :last_name, :patronymic, :email, :motto, :ticket, :mobile_phone, :birth_date, :home_adress, :municipality, :locality, :avatar, :state, :type, :parent_id

  association :positions do
    attributes :title, :begin_date, :end_date, :member_id
  end
end
