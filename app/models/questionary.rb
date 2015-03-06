class Questionary < ActiveRecord::Base
  after_save :update_member
  belongs_to :member

  validates :experience, presence: true
  validates :want_to_do, presence: true

  attr_accessor :first_name, :last_name, :email, :patronymic, :motto, :mobile_phone, :birth_date, :home_adress, :municipality, :locality, :avatar, :state, :user_id

  private

  def update_member
    params = { patronymic: patronymic, motto: motto, mobile_phone: mobile_phone, birth_date: birth_date, home_adress: home_adress, municipality: municipality, locality: locality, avatar: avatar, state: state, user_id: user_id }
    params.keys.each do |key|
      params[key] = nil unless params[key].present?
    end
    if member_id
      member = Member.find member_id
      member.first_name = first_name if first_name.present?
      member.last_name = last_name if last_name.present?
      member.email = email if email.present?
      member.save
      Member.update member_id, params
    else
      Member.create params
      update member_id: Member.last.id
    end
  end
end
