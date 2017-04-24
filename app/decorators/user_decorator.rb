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

  def corporate_email
    object.corporate_email
  end

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
    [ :confirmed, :unviewed, :declined, :email_corrupted ]
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
      h.concat object.send(attribute)
    end
  end

  def show_attribute(attribute)
    if attribute.is_a? Symbol
      case attribute
      when :email, :corporate_email
        mail_to send attribute
      when :mobile_phone
        tel_tag send attribute
      when :birth_date, :join_date, :request_date
        date = send attribute
        I18n.l date, format: '%d %B %Y' if date.present?
      when :municipality, :locality, :join_date, :school
        h.content_tag :a, href: admin_members_path(search: send(attribute)) do
          send attribute
        end
      when :role
        send "#{attribute}_text"
      when :member_state, :state
        object.send "human_#{attribute}_name"
      else
        send attribute
      end
    else
      instance_exec(&attribute.values.first)
    end
  end

  def sites_attributes
    [:id, :role, :state, { sign_in_count: -> { logged_actions_with(action_type: :sign_in).count } }, 
      { views_count: -> { View.where(record_id: object.id, record_type: 'Member').count } },
      { views_by_members: -> { 
        View.where(record_id: object.id, record_type: 'Member', user_id: Member.just_members.map(&:id)).count
      } 
    }] 
  end

  def real_attributes
    [:email]
  end

  def show_human_attribute_name(attribute)
    attr = attribute.is_a?(Symbol) ? attribute : attribute.keys.first
    object.class.human_attribute_name attr
  end

  alias element_avatar profile_avatar
  alias full_name short_name

  private

  def ticket_or_question
    if object.ticket
      "#{ticket}#{ticket ? ' | ' : ''}"
    elsif object.is_questionary?
      "? | "
    end
  end
end
