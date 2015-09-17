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
      "#{ticket_or_question} #{first_name.first}.#{patronymic.first if patronymic}."
    else
      "#{ticket_or_question} #{first_name} #{last_name}"
    end
  end

  private

  def ticket_or_question
    if object.ticket
      "#{ticket}#{ticket ? ' | ' : ''}"
    elsif object.is_questionary?
      "? | "
    end
  end
end
