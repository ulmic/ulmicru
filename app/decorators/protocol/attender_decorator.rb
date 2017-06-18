class Protocol::AttenderDecorator < ApplicationDecorator
  delegate_all

  def name
    "#{object.protocol.decorate.name} | #{object.member.decorate.short_name}"
  end
end
