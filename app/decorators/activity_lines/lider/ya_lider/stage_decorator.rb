class ActivityLines::Lider::YaLider::StageDecorator < ApplicationDecorator
  delegate_all

  def full_title
    "#{object.number} этап #{to_text_in_roman(object.contest.contest_number)} областного конкурса актива учащейся молодёжи «Я-лидер!» #{object.title}"
  end
end
