class ProtocolDecorator < ApplicationDecorator
  delegate_all

  def name
    object.summons
  end

  def title
    "#{object.team.decorate.full_title} | #{object.number}"
  end

  def summons_with_new_line
    object.summons.gsub("\n", "<br>").html_safe
  end

  def invited_with_new_line
    object.invited.gsub("\n", "<br>").html_safe
  end
end
