class UserDecorator < ApplicationDecorator
  delegate_all

  def name
    "#{object&.first_name} #{object&.last_name}"
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

  def small_avatar_url
    if object.type == 'Member' && object.member_confirmed?
      object.avatar.small.url
    else
      object.default_avatar
    end
  end

  alias element_avatar profile_avatar

  def select_presentation(options = {})
    if options[:names] == :official
      "#{ticket_or_question} #{last_name} #{first_name&.first}.#{patronymic&.first}."
    else
      "#{ticket_or_question} #{first_name} #{last_name}"
    end
  end

  def human_type_name
    I18n.t("activerecord.attributes.user.types.#{object.type&.underscore || :user}")
  end

  def self.collections
    [ :confirmed, :unviewed, :declined ]
  end

  def main_current_position
    nil
  end

  def notificable_email
    object.corporate_email.present? ? object.corporate_email : object.email
  end

  def age
    DateTime.now.year - birth_date.year - (birth_date.to_date.change(year: DateTime.now.year) > DateTime.now ? 1 : 0)
  end

  def mobile_phone_link
    h.content_tag :a, href: "tel:#{object.mobile_phone}" do
      h.concat fa_icon :phone
      h.concat ' '
      h.concat object.mobile_phone
    end
  end

  def email_link
    default_email_link :email
  end

  def default_email_link(attribute)
    h.content_tag :a, href: "mail:#{object.send(attribute)}" do
      h.concat fa_icon :envelope
      h.concat ' '
      h.concat object.email
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
