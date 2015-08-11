class MemberForm < ApplicationForm
  self.main_model = :member

  attributes :first_name, :last_name, :patronymic, :email, :motto, :ticket, :mobile_phone, :birth_date, :home_adress, :municipality, :locality, :avatar, :state, :type, required: true
  attributes :state_event, :parent_id, :school

  association :positions do
    attributes :title, :begin_date, :end_date, :member_id, :for_now
  end
end
