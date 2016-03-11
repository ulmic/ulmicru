class QuestionaryDecorator < MemberDecorator
  delegate_all

  def profile_avatar
    object.on_the_trial? ? avatar.profile : default_avatar
  end

  def real_attributes
    [:email, :motto, :mobile_phone, :birth_date, :municipality, :locality, :school, :want_to_do, :experience]
  end

  def show_attribute(attribute)
    case attribute
    when :email
      mail_to send attribute
    when :mobile_phone
      tel_tag send attribute
    when :birth_date, :created_at
      I18n.l send(attribute), format: '%d %B %Y'
    when :municipality, :locality, :school
      h.content_tag :a, href: admin_members_path(search: send(attribute)) do
        send attribute
      end
    else
      send attribute
    end
  end

  def sites_attributes
    [:id, :created_at]
  end
end
