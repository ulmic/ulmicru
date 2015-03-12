class MemberDecorator < Draper::Decorator
  delegate_all
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
    "#{municipality}, #{locality}"
  end
end
