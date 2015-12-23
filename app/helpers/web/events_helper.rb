module Web::EventsHelper
  def current_user_have_attended?(registrations)
    if signed_in?
      registrations.each do |registration|
        return true if registration.user_id == current_user.id
      end
      false
    end
  end

  def link_to_profile(user)
    member_path user.ticket if user.is_member? && user.confirmed?
  end

  def google_id
    oauth = YAML.load_file('config/oauth.yml')
    oauth['development']['google']['client_id']
  end

  def current_registration(registrations)
    registrations.select{|reg| reg.user == current_user}.first
  end
end
