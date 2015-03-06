class Member < ActiveRecord::Base
  after_save :update_user_name

  belongs_to :user
  belongs_to :parent, class_name: 'Member'

  validates :patronymic, presence: true,
                         human_name: true
  validates :motto, presence: true
  validates :ticket, presence: true,
                            uniqueness: true
  validates :mobile_phone, presence: true,
                           phone: true
  validates :birth_date, presence: true
  validates :home_adress, presence: true
  validates :municipality, presence: true
  validates :locality, presence: true
  validates :avatar, presence: true

  scope :presented, -> { where.not(state: :removed) }
  scope :removed, -> { where state: :removed }
  scope :not_confirmed, -> { where state: :not_confirmed }

  state_machine :state, initial: :not_confirmed do
    state :not_confirmed
    state :confirmed
    state :declined
    state :removed
    state :wants_to_join

    event :confirm do
      transition all => :confirmed
    end
    event :decline do
      transition all => :declined
    end
    event :remove do
      transition all => :removed
    end
    event :restore do
      transition removed: :not_confirmed
    end
  end
  attr_accessor :first_name, :last_name, :email

  def update_user_name
    if user_id
      User.update user_id, first_name: first_name if first_name.present?
      User.update user_id, last_name: last_name if last_name.present?
      User.update user_id, email: email if email.present?
    else
      user = User.create(first_name: first_name, last_name: last_name, email: email)
      update user_id: User.last.id
    end
  end
end
