class ActivityLines::Lider::YaLiderDecorator < ApplicationDecorator
  delegate_all

  def self.collections
    [ :current, :past, :removed ]
  end
end
