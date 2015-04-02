class Event::RegistrationDecorator < Draper::Decorator
  delegate_all

  def localize_role
    I18n.t("enumerize.event.registration.role.#{object.role}")
  end

end
