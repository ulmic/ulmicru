class UserDecorator < ApplicationDecorator
  delegate_all

  def name
    "#{first_name} #{last_name}"
  end

  def has_confirmed_member?
    member.confirmed? if member.present?
  end

  def short_name
    "#{first_name} #{last_name}"
  end

  def profile_avatar
    default_avatar
  end

  alias element_avatar profile_avatar

  def select_presentation(options = {})
    if options[:names] == :official
      "#{ticket}#{ticket ? ' | ' : ''} #{last_name} #{first_name.first}.#{patronymic.first if patronymic}."
    else
      "#{ticket}#{ticket ? ' | ' : ''} #{first_name} #{last_name}"
    end
  end
end
