class Member < ActiveRecord::Base
  belongs_to :user
  belongs_to :parent, class_name: 'Member'

  validates :patronymic, presence: true,
                         human_name: true
  validates :motto, presence: true
  validates :ticket_number, presence: true,
                            uniqueness: true
  validates :mobile_phone, presence: true,
                           phone: true
  validates :birth_date, presence: true
  validates :home_adress, presence: true
  validates :municipality, presence: true
  validates :locality, presence: true
  validates :avatar, presence: true
end
