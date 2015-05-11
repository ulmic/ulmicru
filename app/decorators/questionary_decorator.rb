class QuestionaryDecorator < ApplicationDecorator
  delegate_all

  def full_name
    "#{first_name} #{patronymic} #{last_name}"
  end

  def place
    "#{municipality}, #{locality}"
  end

  def name
    full_name
  end
end
