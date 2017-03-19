class ProtocolDecorator < ApplicationDecorator
  delegate_all

  def self.collections
    [ :active, :removed ]
  end
end
