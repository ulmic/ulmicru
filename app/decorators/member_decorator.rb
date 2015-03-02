class MemberDecorator < Draper::Decorator
  delegate_all

  def first_name
    user.first_name
  end

  def last_name
    user.last_name
  end

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
