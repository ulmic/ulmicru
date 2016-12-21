class ActivityLines::Lider::YaLiderDecorator < ApplicationDecorator
  delegate_all

  def full_title
    "#{object.contest_number} областной конкурс актива учащейся молодёжи «Я-лидер!»"
  end

  def self.collections
    [ :current, :past, :removed ]
  end
end
