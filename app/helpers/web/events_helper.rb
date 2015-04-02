module Web::EventsHelper
  def current_user_have_attended?(registrations)
    registrations.each do |registration|
      return true if registration.user_id == current_user.id
    end
    false
  end
end
