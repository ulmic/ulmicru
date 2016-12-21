class ActivityLines::Lider::YaLiderDecorator < ApplicationDecorator
  delegate_all
  include Kabal

  def full_title
    "#{to_text_in_roman(object.contest_number)} областной конкурс актива учащейся молодёжи «Я-лидер!»"
  end

  def self.collections
    [ :current, :past, :removed ]
  end
end
