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

  def short_name_link
    h.content_tag :a, href: member_path(object.ticket) do
      "#{first_name} #{last_name}"
    end
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
    position = main_current_position_title
    return position if position.present?
    last_held_position = positions.last_held_position
    unless last_held_position == []
      last_held_position.title if last_held_position
    end
  end

  def main_current_position_title
    if object.positions.current_positions.any?
      return object.positions.current_positions.to_a.sort_by! { |p| PositionList.list.index(p.title) }.first.title
    end
  end

  def main_current_position
    if object.positions.current_positions.any?
      object.positions.current_positions.to_a.sort_by! { |p| PositionList.list.index(p.title) }.first
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

  def avatar_small_img
    h.content_tag :a, href: member_path(object.ticket) do
      h.content_tag :img, class: :avatar, src: object.avatar.small do
      end
    end
  end

  def mobile_phone_link
    h.content_tag :a, href: "tel:#{object.mobile_phone}" do
      h.concat fa_icon :phone
      h.concat ' '
      h.concat object.mobile_phone
    end
  end

  def email_link
    h.content_tag :a, href: "mail:#{object.email}" do
      h.concat fa_icon :envelope
      h.concat ' '
      h.concat object.email
    end
  end

  include SocialNetworksUrlHelper

  def social_links
    h.content_tag :div, class: :row do
      SocialNetworks.list.each do |s_network|
        h.concat(h.content_tag(:div, class: "small-3 columns social_links #{s_network}") do
          auth = object.has_auth_provider? s_network
          if auth && attribute_visible?(object.attribute_accesses, s_network)
            h.content_tag :a, href: profile_url(auth) do
              fa_icon "#{s_network == 'vkontakte' ? :vk : s_network} 2x"
            end
          end
        end)
      end
    end
  end

  private

  def attribute_visible?(accesses, attribute)
    attr_access = accesses.find_by_member_attribute attribute
    attr_access.access.visible? if attr_access
  end
end
