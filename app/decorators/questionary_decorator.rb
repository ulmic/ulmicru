class QuestionaryDecorator < Draper::Decorator
  delegate_all

  def first_name
    member.user.first_name
  end

  def last_name
    member.user.last_name
  end

  def patronymic
    member.patronymic
  end

  def full_name
    "#{first_name} #{patronymic} #{last_name}"
  end

  def place
    "#{member.municipality}, #{member.locality}"
  end

  def name
    full_name
  end
end
