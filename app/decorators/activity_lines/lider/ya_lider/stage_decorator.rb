class ActivityLines::Lider::YaLider::StageDecorator < ApplicationDecorator
  delegate_all

  decorates_association :participants

  def name
    full_title
  end

  def full_title
    "#{object.number} этап #{to_text_in_roman(object.contest.contest_number)} областного конкурса актива учащейся молодёжи «Я-лидер!» #{object.title}"
  end

  def is_the_first?
    number == 1
  end
end
