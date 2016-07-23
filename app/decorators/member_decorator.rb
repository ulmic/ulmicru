class MemberDecorator < UserDecorator
  delegate_all

  decorates_association :teams
  decorates_association :parent

  def full_name
    "#{first_name} #{patronymic} #{last_name}"
  end

  def name
    full_name
  end

  def short_name
    "#{first_name} #{last_name}"
  end

  def place
    if municipality.include? 'г.'
      locality
    else
      "#{municipality}, #{locality}"
    end
  end

  def position_duration
    last_held_position = positions.last_held_position
    last_held_position.duration if last_held_position.present? && last_held_position.duration.present?
  end

  def main_position_title
    for_now_positions = positions.current_positions
    return for_now_positions.first.title if for_now_positions.any?
    last_held_position = positions.last_held_position
    unless last_held_position == []
      last_held_position.title if last_held_position
    end
  end

  def ticket_number
    "№ #{ticket}"
  end

  def parent_avatar
    parent.avatar.medium if parent.present?
  end

  def profile_avatar
    avatar.profile if avatar
  end

  def presentation
    h.content_tag :a, href: admin_member_path(id) do
      short_name
    end
  end

  alias to_s presentation

  def element_avatar
    if avatar.present? && confirmed?
      avatar.element
    else
      default_avatar
    end
  end

  def real_attributes
    [:ticket, :email, :motto, :parent, :mobile_phone, :birth_date, :municipality, :locality, 
     :join_date, :school, :main_position_title]
  end

  def show_attribute(attribute)
    if attribute.is_a? Symbol
      case attribute
      when :email
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
	human_state_name send attribute
      else
	send attribute
      end
    else
      instance_exec(&attribute.values.first)
    end
  end

  def show_human_attribute_name(attribute)
    attr = attribute.is_a?(Symbol) ? attribute : attribute.keys.first
    object.class.human_attribute_name attr
  end

  def sites_attributes
    [:id, :role, :state, { sign_in_count: -> { logged_actions_with(action_type: :sign_in).count } }] 
  end

  def self.collections
    [ :confirmed, :unviewed, :declined, :unavailable ]
  end

  def email
    object.email
  end
end
