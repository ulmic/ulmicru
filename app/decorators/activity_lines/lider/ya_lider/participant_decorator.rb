class ActivityLines::Lider::YaLider::ParticipantDecorator < ApplicationDecorator
  delegate_all

  decorates_association :user

  def name
    if object.present?
      object.user.decorate.short_name
    end
  end

  def self.collections
    [:active, :won, :lost, :declined]
  end

  def full_name
    "#{object.user.first_name} #{object.user.patronymic} #{object.user.last_name}"
  end

  def small_avatar
    object.user.avatar.small
  end
  
  def small_avatar_url
    object.user.avatar.small.url
  end

  def is_member?
    user.is_member? && user.member_confirmed?
  end

  def contest_attributes
    [ :email_link, :locality, :school, :mobile_phone_link, :birth_date ]
  end

  delegate :municipality, to: :user
  delegate :short_name, to: :user
end
