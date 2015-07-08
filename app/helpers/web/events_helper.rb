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
end
