class RedirectRuleDecorator < ApplicationDecorator
  delegate_all

  def self.collections
    [ :active ]
  end
end
