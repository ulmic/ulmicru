class Questionary < ActiveRecord::Base
  after_save :update_member
  belongs_to :member

  validates :experience, presence: true
  validates :want_to_do, presence: true

  scope :unviewed, -> { where state: :unviewed }
  scope :presented, -> { where.not(state: :removed) }
  scope :removed, -> { where state: :removed }

  state_machine :state, initial: :unviewed do
    state :unviewed
    state :confirmed
    state :declined
    state :on_the_trial
    state :removed

    event :confirm do
      transition all => :confirmed
    end
    event :decline do
      transition all => :declined
    end
    event :put_on_the_trial do
      transition all => :on_the_trial
    end
    event :remove do
      transition all => :removed
    end
    event :restore do
      transition removed: :unviewed
    end
  end

  def user
    member.user if member
  end

  attr_accessor :first_name, :last_name, :email, :patronymic, :motto, :mobile_phone, :birth_date, :home_adress, :municipality, :locality, :avatar, :user_id, :ticket

  private

  def update_member
    params = { patronymic: patronymic, motto: motto, mobile_phone: mobile_phone, birth_date: birth_date, home_adress: home_adress, municipality: municipality, locality: locality, avatar: avatar, state: :not_member, user_id: user_id, ticket: ticket }
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
