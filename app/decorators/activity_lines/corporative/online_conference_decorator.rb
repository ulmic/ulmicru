class ActivityLines::Corporative::OnlineConferenceDecorator < ApplicationDecorator
  delegate_all

  def name
    object.title
  end

  def self.collections
    [ :future, :past, :removed ]
  end
end
