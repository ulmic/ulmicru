class ActivityLines::Lider::YaLiderDecorator < ApplicationDecorator
  delegate_all

  def full_title
    "#{to_text_in_roman(object.contest_number)} областной конкурс актива учащейся молодёжи «Я-лидер!»"
  end

  alias title full_title

  def self.collections
    [ :current, :past, :removed ]
  end
end
