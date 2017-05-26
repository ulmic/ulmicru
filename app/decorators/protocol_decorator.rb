class ProtocolDecorator < ApplicationDecorator
  delegate_all

  def name
    object.title
  end

  def title
    "#{object.team.decorate.full_title} | #{object.number}"
  end
end
