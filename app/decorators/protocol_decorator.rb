class ProtocolDecorator < ApplicationDecorator
  delegate_all

  def name
    object.title
  end
end
