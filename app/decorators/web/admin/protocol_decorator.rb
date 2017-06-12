class Web::Admin::ProtocolDecorator < ApplicationDecorator
  delegate_all

  def self.collections
    [ :not_filled, :active ]
  end
end
