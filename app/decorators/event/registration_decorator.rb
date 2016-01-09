class Event::RegistrationDecorator < Draper::Decorator
  delegate_all

  decorates_association :user

  def localize_role
    I18n.t("enumerize.event/registration.role.#{object.role}")
  end
end
