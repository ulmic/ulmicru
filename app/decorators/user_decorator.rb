class UserDecorator < Draper::Decorator
  delegate_all

  def name
    "#{first_name} #{last_name}"
  end

  def has_confirmed_member?
    member.confirmed? if member.present?
  end

  def has_member?
    not member.removed? if member.present?
  end
end
