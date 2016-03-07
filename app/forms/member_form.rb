class MemberForm < ApplicationForm
  self.main_model = :member

  attributes :first_name, :last_name, :patronymic, :email, :motto, :ticket, :mobile_phone, :birth_date, :home_adress, :municipality, :locality, :avatar, :state, :type, required: true
  attributes :state_event, :parent_id, :school, :password

  association :positions do
    attributes :title, :begin_date, :member_id, :state, :end_date, :for_now
  end

  def check_complies(**params)
    unless first_name == params[:first_name] && first_name == params[:last_name] && 
       first_name == params[:patronymic] && first_name == params[:ticket]
      errors.add :ticket, I18n.t('validations.errors.wrong_ticket_or_member_not_exists')
    end
  end

  def check_repeated_registration
    unless unavailable?
      errors.add :ticket, I18n.t('validations.you_already_have_an_member_account')
    end
  end
end
